import SwiftUI

struct TransactionsView: View {
    @State private var searchText = ""
    @State private var selectedFilter = 0
    
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
                        Text("May 2026")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                            .padding(.bottom, 16)
                        
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
    }
    
    var sampleTransactions: [Transaction] {
        [
            Transaction(amount: 45.50, category: .groceries, date: Date(), note: "Supermarket", isExpense: true),
            Transaction(amount: 35.00, category: .dining, date: Date(), note: "Lunch with team", isExpense: true),
            Transaction(amount: 1200.00, category: .salary, date: Date(), note: "Monthly salary", isExpense: false),
            Transaction(amount: 60.00, category: .transport, date: Date(), note: "Fuel", isExpense: true),
            Transaction(amount: 25.99, category: .entertainment, date: Date(), note: "Netflix subscription", isExpense: true)
        ]
    }
}
