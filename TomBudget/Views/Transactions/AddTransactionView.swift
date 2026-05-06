import SwiftUI
import CoreData

struct AddTransactionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var amount = ""
    @State private var selectedCategory: Transaction.Category = .groceries
    @State private var date = Date()
    @State private var note = ""
    @State private var isExpense = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Amount Input
                GlassCard {
                    VStack(spacing: 8) {
                        Text("Amount")
                            .font(.labelSM)
                            .foregroundColor(.tombudgetOnSurfaceVariant)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            Text("$")
                                .font(.displayAmount)
                                .foregroundColor(.tombudgetOnSurfaceVariant)
                            TextField("0.00", text: $amount)
                                .font(.displayAmount)
                                .keyboardType(.decimalPad)
                        }
                    }
                }
                
                // Type Selector
                HStack(spacing: 12) {
                    Button(action: { isExpense = true }) {
                        Text("Expense")
                            .font(.headlineMD)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(isExpense ? Color.tombudgetTertiary : Color.tombudgetSurfaceContainer)
                            .foregroundColor(isExpense ? .white : .tombudgetOnSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Button(action: { isExpense = false }) {
                        Text("Income")
                            .font(.headlineMD)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(!isExpense ? Color.tombudgetSecondary : Color.tombudgetSurfaceContainer)
                            .foregroundColor(!isExpense ? .white : .tombudgetOnSurface)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                
                // Category Grid
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Category")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 12) {
                            ForEach(Transaction.Category.allCases, id: \.self) { category in
                                CategoryButton(
                                    category: category,
                                    isSelected: selectedCategory == category
                                ) {
                                    selectedCategory = category
                                }
                            }
                        }
                    }
                }
                
                // Date & Note
                GlassCard {
                    VStack(spacing: 16) {
                        DatePicker("Date", selection: $date, displayedComponents: .date)
                            .font(.bodyLG)
                        
                        Divider()
                        
                        TextField("Note (optional)", text: $note)
                            .font(.bodyLG)
                    }
                }
                
                // Save Button
                Button(action: saveTransaction) {
                    Text("Save Transaction")
                        .font(.headlineMD)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.tombudgetPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 100)
        }
        .background(Color.tombudgetBackground.ignoresSafeArea())
        .navigationBarHidden(true)
    }
    
    private func saveTransaction() {
        guard let amountValue = Double(amount) else { return }
        
        let entity = TransactionEntity(context: viewContext)
        entity.id = UUID()
        entity.amount = amountValue
        entity.category = selectedCategory.rawValue
        entity.date = date
        entity.note = note.isEmpty ? nil : note
        entity.isExpense = isExpense
        
        do {
            try viewContext.save()
            amount = ""
            note = ""
        } catch {
            print("Save error: \(error)")
        }
    }
}

struct CategoryButton: View {
    let category: Transaction.Category
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Circle()
                    .fill(isSelected ? category.color : category.color.opacity(0.3))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: category.icon)
                            .font(.system(size: 20))
                            .foregroundColor(isSelected ? .white : category.color)
                    )
                
                Text(category.rawValue)
                    .font(.labelCaps)
                    .foregroundColor(isSelected ? .tombudgetOnSurface : .tombudgetOnSurfaceVariant)
                    .lineLimit(1)
            }
            .padding(.vertical, 8)
        }
    }
}
