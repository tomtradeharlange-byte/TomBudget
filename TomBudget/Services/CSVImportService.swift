import Foundation

class CSVImportService {
    static let shared = CSVImportService()
    
    func parseCSV(content: String) -> [[String]] {
        var rows: [[String]] = []
        let lines = content.components(separatedBy: "\n")
        
        for line in lines where !line.isEmpty {
            let columns = parseCSVLine(line)
            rows.append(columns)
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
}

struct ColumnMapping {
    let dateColumn: Int
    let amountColumn: Int
    let descriptionColumn: Int?
    let categoryColumn: Int?
    
    static let `default` = ColumnMapping(dateColumn: 0, amountColumn: 1, descriptionColumn: 2, categoryColumn: 3)
}

struct ImportPreviewView: View {
    let csvRows: [[String]]
    @State private var mapping = ColumnMapping.default
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Column Mapping
                    GlassCard {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Map Columns")
                                .font(.headlineMD)
                                .foregroundColor(.tombudgetOnSurface)
                            
                            MappingRow(title: "Date", columnIndex: $mapping.dateColumn, columns: headers)
                            MappingRow(title: "Amount", columnIndex: $mapping.amountColumn, columns: headers)
                            MappingRow(title: "Description", columnIndex: Binding(get: { mapping.descriptionColumn ?? -1 }, set: { mapping.descriptionColumn = $0 }), columns: headers)
                            MappingRow(title: "Category", columnIndex: Binding(get: { mapping.categoryColumn ?? -1 }, set: { mapping.categoryColumn = $0 }), columns: headers)
                        }
                    }
                    
                    // Preview
                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Preview")
                                .font(.headlineMD)
                                .foregroundColor(.tombudgetOnSurface)
                            
                            ForEach(Array(csvRows.prefix(5).enumerated()), id: \.offset) { index, row in
                                HStack {
                                    Text(row[safe: mapping.dateColumn] ?? "-")
                                        .font(.labelSM)
                                    Spacer()
                                    Text(row[safe: mapping.amountColumn] ?? "-")
                                        .font(.headlineMD)
                                        .foregroundColor(.tombudgetSecondary)
                                }
                                if index < 4 { Divider() }
                            }
                        }
                    }
                    
                    Button(action: importData) {
                        Text("Import Transactions")
                            .font(.headlineMD)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.tombudgetPrimary)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(20)
            }
            .background(Color.tombudgetBackground.ignoresSafeArea())
            .navigationTitle("Import CSV")
            .navigationBarItems(trailing: Button("Cancel") { presentationMode.wrappedValue.dismiss() })
        }
    }
    
    var headers: [String] {
        csvRows.first ?? []
    }
    
    func importData() {
        // TODO: Implement import with mapping
    }
}

struct MappingRow: View {
    let title: String
    @Binding var columnIndex: Int
    let columns: [String]
    
    var body: some View {
        HStack {
            Text(title)
                .font(.bodyLG)
                .foregroundColor(.tombudgetOnSurface)
                .frame(width: 100, alignment: .leading)
            
            Picker("", selection: $columnIndex) {
                Text("None").tag(-1)
                ForEach(0..<columns.count, id: \.self) { index in
                    Text(columns[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
