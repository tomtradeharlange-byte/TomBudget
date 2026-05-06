import SwiftUI
import CoreData

struct TransactionsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TransactionEntity.date, ascending: false)],
        animation: .default)
    private var transactions: FetchedResults<TransactionEntity>
    
    @State private var searchText = ""
    @State private var selectedFilter = 0
    @State private var showingImport = false
    
    let filters = ["All", "Expenses", "Income"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.tombudgetOnSurfaceVariant)
                    TextField("Search transactions", text: $searchText)
                        .font(.bodyLG)
                }
                .padding(12)
                .glassCard()
                
                // Filters
                HStack(spacing: 12) {
                    ForEach(0..<filters.count, id: \.self) { index in
                        Button(action: { selectedFilter = index }) {
                            Text(filters[index])
                                .font(.labelCaps)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(selectedFilter == index ? Color.tombudgetPrimary : Color.clear)
                                .foregroundColor(selectedFilter == index ? .white : .tombudgetOnSurfaceVariant)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(selectedFilter == index ? Color.clear : Color.tombudgetOutline.opacity(0.3), lineWidth: 1)
                                )
                        }
                    }
                    Spacer()
                }
                
                // Transactions List
                GlassCard {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            Text("May 2026")
                                .font(.headlineMD)
                                .foregroundColor(.tombudgetOnSurface)
                                .padding(.bottom, 16)
                            Spacer()
                            Button(action: { showingImport = true }) {
                                Image(systemName: "square.and.arrow.down")
                                    .font(.system(size: 18))
                                    .foregroundColor(.tombudgetPrimary)
                            }
                        }
                        
                        ForEach(sampleTransactions) { transaction in
                            TransactionRow(transaction: transaction)
                            if transaction.id != sampleTransactions.last?.id {
                                Divider()
                                    .padding(.vertical, 12)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 100)
        }
        .background(Color.tombudgetBackground.ignoresSafeArea())
        .navigationBarHidden(true)
        .sheet(isPresented: $showingImport) {
            CSVImportView()
        }
    }
    
    var sampleTransactions: [Transaction] {
        transactions.map { entity in
            Transaction(
                amount: entity.amount,
                category: Transaction.Category(rawValue: entity.category ?? "") ?? .groceries,
                date: entity.date ?? Date(),
                note: entity.note,
                isExpense: entity.isExpense
            )
        }
    }
}
