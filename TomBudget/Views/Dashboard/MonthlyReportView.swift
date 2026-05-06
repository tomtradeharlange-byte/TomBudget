import SwiftUI
import Charts

struct MonthlyReportView: View {
    @State private var selectedMonth = 0
    let months = ["May 2026", "April 2026", "March 2026"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Month Selector
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.tombudgetPrimary)
                    }
                    
                    Spacer()
                    
                    Text(months[selectedMonth])
                        .font(.headlineLG)
                        .foregroundColor(.tombudgetOnSurface)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.tombudgetPrimary)
                    }
                }
                
                // Summary Cards
                HStack(spacing: 12) {
                    SummaryCard(title: "Income", amount: 3200.00, color: .tombudgetSecondary)
                    SummaryCard(title: "Expenses", amount: 2450.80, color: .tombudgetTertiary)
                }
                
                // Bar Chart - Income vs Expenses
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Income vs Expenses")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        Chart(sampleMonthlyData) { item in
                            BarMark(
                                x: .value("Day", item.day),
                                y: .value("Income", item.income)
                            )
                            .foregroundStyle(Color.tombudgetSecondary.gradient)
                            
                            BarMark(
                                x: .value("Day", item.day),
                                y: .value("Expenses", item.expense)
                            )
                            .foregroundStyle(Color.tombudgetTertiary.gradient)
                        }
                        .frame(height: 200)
                        .chartXAxis {
                            AxisMarks(values: .stride(by: 5)) { _ in
                                AxisValueLabel()
                                    .font(.system(size: 10))
                            }
                        }
                    }
                }
                
                // Category Breakdown
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Spending by Category")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        Chart(sampleCategoryData) { item in
                            SectorMark(
                                angle: .value("Amount", item.amount),
                                innerRadius: .ratio(0.6),
                                angularInset: 2
                            )
                            .foregroundStyle(item.color)
                        }
                        .frame(height: 200)
                        
                        // Legend
                        VStack(spacing: 8) {
                            ForEach(sampleCategoryData) { item in
                                HStack {
                                    Circle()
                                        .fill(item.color)
                                        .frame(width: 8, height: 8)
                                    Text(item.category)
                                        .font(.labelSM)
                                        .foregroundColor(.tombudgetOnSurfaceVariant)
                                    Spacer()
                                    Text("$\(Int(item.amount))")
                                        .font(.labelSM)
                                        .foregroundColor(.tombudgetOnSurface)
                                }
                            }
                        }
                    }
                }
                
                // Export Button
                Button(action: {}) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Export Report")
                            .font(.headlineMD)
                    }
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
    }
}

struct SummaryCard: View {
    let title: String
    let amount: Double
    let color: Color
    
    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.labelSM)
                    .foregroundColor(.tombudgetOnSurfaceVariant)
                Text(amount, format: .currency(code: "USD"))
                    .font(.headlineMD)
                    .foregroundColor(color)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct MonthlyData: Identifiable {
    let id = UUID()
    let day: Int
    let income: Double
    let expense: Double
}

struct CategoryData: Identifiable {
    let id = UUID()
    let category: String
    let amount: Double
    let color: Color
}

let sampleMonthlyData: [MonthlyData] = (1...30).map { day in
    MonthlyData(day: day, income: day == 15 ? 3200 : 0, expense: Double.random(in: 50...150))
}

let sampleCategoryData: [CategoryData] = [
    CategoryData(category: "Groceries", amount: 650, color: Color(hex: "#a1f0c9")),
    CategoryData(category: "Dining", amount: 450, color: Color(hex: "#ffdad4")),
    CategoryData(category: "Transport", amount: 300, color: Color(hex: "#bfc2ff")),
    CategoryData(category: "Entertainment", amount: 250, color: Color(hex: "#ffb4a8")),
    CategoryData(category: "Shopping", amount: 400, color: Color(hex: "#e0e0ff")),
    CategoryData(category: "Other", amount: 400, color: Color(hex: "#6067df"))
]
