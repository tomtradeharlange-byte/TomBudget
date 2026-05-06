import Foundation
import CoreData

class CSVImportService {
    static let shared = CSVImportService()
    
    func parseCSV(content: String) -> [[String]] {
        var rows: [[String]] = []
        let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }
        
        for line in lines {
            let columns = parseCSVLine(line)
            if !columns.isEmpty {
                rows.append(columns)
            }
        }
        
        return rows
    }
    
    private func parseCSVLine(_ line: String) -> [String] {
        var result: [String] = []
        var current = ""
        var inQuotes = false
        
        for char in line {
            if char == "\"" {
                inQuotes.toggle()
            } else if char == "," && !inQuotes {
                result.append(current.trimmingCharacters(in: .whitespaces))
                current = ""
            } else {
                current.append(char)
            }
        }
        result.append(current.trimmingCharacters(in: .whitespaces))
        
        return result
    }
    
    func importTransactions(
        rows: [[String]],
        mapping: ColumnMapping,
        context: NSManagedObjectContext
    ) -> Int {
        var importedCount = 0
        
        // Skip header row
        for row in rows.dropFirst() {
            guard row.count > max(mapping.dateColumn, mapping.amountColumn) else { continue }
            
            let dateStr = row[mapping.dateColumn]
            let amountStr = row[mapping.amountColumn]
            let note = mapping.descriptionColumn != nil && mapping.descriptionColumn! < row.count ? row[mapping.descriptionColumn!] : nil
            let categoryStr = mapping.categoryColumn != nil && mapping.categoryColumn! < row.count ? row[mapping.categoryColumn!] : nil
            
            guard let amount = parseAmount(amountStr),
                  let date = parseDate(dateStr) else { continue }
            
            let entity = TransactionEntity(context: context)
            entity.id = UUID()
            entity.amount = abs(amount)
            entity.date = date
            entity.note = note
            entity.isExpense = amount < 0
            entity.category = categoryStr ?? Transaction.Category.groceries.rawValue
            
            importedCount += 1
        }
        
        do {
            try context.save()
        } catch {
            print("Import save error: \(error)")
            return 0
        }
        
        return importedCount
    }
    
    private func parseAmount(_ str: String) -> Double? {
        let cleaned = str.replacingOccurrences(of: "$", with: "")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ",", with: "")
        return Double(cleaned)
    }
    
    private func parseDate(_ str: String) -> Date? {
        let formatters = [
            "yyyy-MM-dd",
            "MM/dd/yyyy",
            "dd/MM/yyyy",
            "yyyy-MM-dd HH:mm:ss"
        ].map { format in
            let f = DateFormatter()
            f.dateFormat = format
            return f
        }
        
        for formatter in formatters {
            if let date = formatter.date(from: str) {
                return date
            }
        }
        
        return nil
    }
}

struct ColumnMapping {
    let dateColumn: Int
    let amountColumn: Int
    let descriptionColumn: Int?
    let categoryColumn: Int?
    
    static let `default` = ColumnMapping(dateColumn: 0, amountColumn: 1, descriptionColumn: 2, categoryColumn: 3)
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
