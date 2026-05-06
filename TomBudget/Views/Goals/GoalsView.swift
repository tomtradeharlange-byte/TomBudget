import SwiftUI

struct GoalsView: View {
    @State private var goals: [SavingsGoal] = sampleGoals
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                HStack {
                    Text("Savings Goals")
                        .font(.headlineLG)
                        .foregroundColor(.tombudgetOnSurface)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.tombudgetPrimary)
                    }
                }
                
                // Total Progress
                GlassCard {
                    VStack(spacing: 12) {
                        HStack {
                            Text("Total Saved")
                                .font(.labelSM)
                                .foregroundColor(.tombudgetOnSurfaceVariant)
                            Spacer()
                            Text("$2,850 / $5,000")
                                .font(.headlineMD)
                                .foregroundColor(.tombudgetPrimary)
                        }
                        
                        GeometryReader { geo in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.tombudgetSurfaceContainerHighest)
                                    .frame(height: 12)
                                    .clipShape(Capsule())
                                
                                Rectangle()
                                    .fill(LinearGradient(colors: [.tombudgetPrimary, .tombudgetSecondary], startPoint: .leading, endPoint: .trailing))
                                    .frame(width: geo.size.width * 0.57, height: 12)
                                    .clipShape(Capsule())
                            }
                        }
                        .frame(height: 12)
                        
                        Text("57% of total goals")
                            .font(.labelCaps)
                            .foregroundColor(.tombudgetOnSurfaceVariant)
                    }
                }
                
                // Individual Goals
                ForEach($goals) { $goal in
                    GoalCard(goal: $goal)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 100)
        }
        .background(Color.tombudgetBackground.ignoresSafeArea())
        .navigationBarHidden(true)
    }
}

struct GoalCard: View {
    @Binding var goal: SavingsGoal
    
    var body: some View {
        GlassCard {
            VStack(spacing: 16) {
                HStack {
                    Circle()
                        .fill(goal.color.opacity(0.3))
                        .frame(width: 44, height: 44)
                        .overlay(
                            Image(systemName: goal.icon)
                                .font(.system(size: 20))
                                .foregroundColor(goal.color)
                        )
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(goal.name)
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        Text("$\(Int(goal.current)) / $\(Int(goal.target))")
                            .font(.labelSM)
                            .foregroundColor(.tombudgetOnSurfaceVariant)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.tombudgetPrimary)
                    }
                }
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.tombudgetSurfaceContainerHighest)
                            .frame(height: 8)
                            .clipShape(Capsule())
                        
                        Rectangle()
                            .fill(goal.color)
                            .frame(width: geo.size.width * min(goal.current / goal.target, 1.0), height: 8)
                            .clipShape(Capsule())
                    }
                }
                .frame(height: 8)
            }
        }
    }
}

struct SavingsGoal: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let color: Color
    var current: Double
    let target: Double
}

let sampleGoals: [SavingsGoal] = [
    SavingsGoal(name: "New Laptop", icon: "laptopcomputer", color: .tombudgetPrimary, current: 1200, target: 2000),
    SavingsGoal(name: "Vacation", icon: "airplane", color: .tombudgetSecondary, current: 1500, target: 3000),
    SavingsGoal(name: "Emergency Fund", icon: "shield.fill", color: .tombudgetTertiary, current: 150, target: 1000)
]
