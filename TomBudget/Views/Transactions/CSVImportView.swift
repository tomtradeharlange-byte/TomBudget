import SwiftUI
import UniformTypeIdentifiers
import CoreData

struct CSVImportView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var csvRows: [[String]] = []
    @State private var mapping = ColumnMapping.default
    @State private var showingFilePicker = false
    @State private var importedCount = 0
    @State private var showingResult = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // File Selection
                    GlassCard {
                        Button(action: { showingFilePicker = true }) {
                            HStack {
                                Image(systemName: "doc.text.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(.tombudgetPrimary)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Select CSV File")
                                        .font(.headlineMD)
                                        .foregroundColor(.tombudgetOnSurface)
                                    Text("Tap to import transactions")
                                        .font(.labelSM)
                                        .foregroundColor(.tombudgetOnSurfaceVariant)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.tombudgetOnSurfaceVariant)
                            }
                        }
                    }
                    
                    if !csvRows.isEmpty {
                        // Column Mapping
                        GlassCard {
                            VStack(alignment: .leading, spacing: 16) {
                                Text("Map Columns")
                                    .font(.headlineMD)
                                    .foregroundColor(.tombudgetOnSurface)
                                
                                MappingRow(title: "Date", columnIndex: $mapping.dateColumn, columns: csvRows.first ?? [])
                                MappingRow(title: "Amount", columnIndex: $mapping.amountColumn, columns: csvRows.first ?? [])
                                MappingRow(title: "Description", columnIndex: Binding(get: { mapping.descriptionColumn ?? -1 }, set: { mapping.descriptionColumn = $0 == -1 ? nil : $0 }), columns: csvRows.first ?? [])
                                MappingRow(title: "Category", columnIndex: Binding(get: { mapping.categoryColumn ?? -1 }, set: { mapping.categoryColumn = $0 == -1 ? nil : $0 }), columns: csvRows.first ?? [])
                            }
                        }
                        
                        // Preview
                        GlassCard {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Preview")
                                    .font(.headlineMD)
                                    .foregroundColor(.tombudgetOnSurface)
                                
                                ForEach(Array(csvRows.prefix(6).enumerated()), id: \.offset) { index, row in
                                    if index > 0 { // Skip header
                                        HStack {
                                            Text(row[safe: mapping.dateColumn] ?? "-")
                                                .font(.labelSM)
                                                .foregroundColor(.tombudgetOnSurfaceVariant)
                                            Spacer()
                                            Text(row[safe: mapping.amountColumn] ?? "-")
                                                .font(.headlineMD)
                                                .foregroundColor(.tombudgetSecondary)
                                        }
                                    }
                                    if index < 5 { Divider() }
                                }
                            }
                        }
                        
                        // Import Button
                        Button(action: importData) {
                            Text("Import \(max(0, csvRows.count - 1)) Transactions")
                                .font(.headlineMD)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Color.tombudgetPrimary)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                    }
                }
                .padding(20)
            }
            .background(Color.tombudgetBackground.ignoresSafeArea())
            .navigationTitle("Import CSV")
            .navigationBarItems(trailing: Button("Cancel") { presentationMode.wrappedValue.dismiss() })
            .sheet(isPresented: $showingFilePicker) {
                DocumentPicker(csvRows: $csvRows)
            }
            .alert("Import Complete", isPresented: $showingResult) {
                Button("OK") {
                    if importedCount > 0 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            } message: {
                Text("\(importedCount) transactions imported successfully.")
            }
        }
    }
    
    private func importData() {
        importedCount = CSVImportService.shared.importTransactions(
            rows: csvRows,
            mapping: mapping,
            context: viewContext
        )
        showingResult = true
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

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var csvRows: [[String]]
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.commaSeparatedText])
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(csvRows: $csvRows, presentationMode: presentationMode)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        let csvRows: Binding<[[String]]>
        let presentationMode: Binding<PresentationMode>
        
        init(csvRows: Binding<[[String]]>, presentationMode: Binding<PresentationMode>) {
            self.csvRows = csvRows
            self.presentationMode = presentationMode
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            
            do {
                let content = try String(contentsOf: url)
                csvRows.wrappedValue = CSVImportService.shared.parseCSV(content: content)
            } catch {
                print("Error reading file: \(error)")
            }
            
            presentationMode.wrappedValue.dismiss()
        }
    }
}
