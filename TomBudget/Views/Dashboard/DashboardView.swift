import SwiftUI

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TransactionEntity.date, ascending: false)],
        animation: .default)
    private var transactions: FetchedResults<TransactionEntity>
    
    @State private var totalRemaining: Double = 2450.80
    @State private var monthlyBudget: Double = 4000.00
    @State private var progress: Double = 0.65
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Total Remaining Card
                GlassCard {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Total Remaining")
                                .font(.labelSM)
                                .foregroundColor(.tombudgetOnSurfaceVariant)
                            Spacer()
                            Text("August")
                                .font(.system(size: 11, weight: .bold))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 2)
                                .background(Color.tombudgetSecondaryContainer)
                                .foregroundColor(.tombudgetOnSecondaryContainer)
                                .clipShape(Capsule())
                        }
                        
                        Text(totalRemaining, format: .currency(code: "USD"))
                            .font(.displayAmount)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        HStack {
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .fill(Color.tombudgetSurfaceContainerHighest)
                                        .frame(height: 8)
                                        .clipShape(Capsule())
                                    
                                    LinearGradient(
                                        colors: [.tombudgetPrimary, .tombudgetPrimaryContainer],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                    .frame(width: geo.size.width * progress, height: 8)
                                    .clipShape(Capsule())
                                }
                            }
                            .frame(height: 8)
                            
                            Text("\(Int(progress * 100))% left")
                                .font(.labelSM)
                                .foregroundColor(.tombudgetPrimary)
                        }
                    }
                }
                
                // Quick Actions
                HStack(spacing: 12) {
                    QuickActionButton(icon: "plus.circle.fill", title: "Add Expense", color: .tombudgetTertiary)
                    QuickActionButton(icon: "chart.bar.fill", title: "Reports", color: .tombudgetPrimary)
                    QuickActionButton(icon: "flag.fill", title: "Goals", color: .tombudgetSecondary)
                }
                
                // Recent Transactions
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Recent Transactions")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        ForEach(sampleTransactions) { transaction in
                            TransactionRow(transaction: transaction)
                            if transaction.id != sampleTransactions.last?.id {
                                Divider()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 100)
        }
        .background(
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color(hex: "#e0e0ff"), Color.tombudgetBackground]),
                    center: .topTrailing,
                    startRadius: 0,
                    endRadius: 500
                )
                RadialGradient(
                    gradient: Gradient(colors: [Color(hex: "#a4f3cb"), Color.tombudgetBackground]),
                    center: .bottomLeading,
                    startRadius: 0,
                    endRadius: 500
                )
            }
            .ignoresSafeArea()
        )
        .navigationBarHidden(true)
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

struct QuickActionButton: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundColor(color)
                Text(title)
                    .font(.labelCaps)
                    .foregroundColor(.tombudgetOnSurfaceVariant)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(Color.tombudgetSurfaceContainerLowest.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
        }
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(transaction.category.color)
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: transaction.category.icon)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.category.rawValue)
                    .font(.headlineMD)
                    .foregroundColor(.tombudgetOnSurface)
                if let note = transaction.note {
                    Text(note)
                        .font(.labelSM)
                        .foregroundColor(.tombudgetOnSurfaceVariant)
                }
            }
            
            Spacer()
            
            Text(transaction.amount, format: .currency(code: "USD"))
                .font(.headlineMD)
                .foregroundColor(transaction.isExpense ? .tombudgetTertiary : .tombudgetSecondary)
        }
    }
}
