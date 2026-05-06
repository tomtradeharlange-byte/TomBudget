import SwiftUI
import UserNotifications

struct AlertsView: View {
    @State private var budgetAlertEnabled = true
    @State private var dailyAlertEnabled = true
    @State private var threshold: Double = 80.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Budget Alerts
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Budget Alerts")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        Toggle(isOn: $budgetAlertEnabled) {
                            HStack(spacing: 12) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.tombudgetTertiary)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Budget Exceeded")
                                        .font(.bodyLG)
                                        .foregroundColor(.tombudgetOnSurface)
                                    Text("Notify when budget is exceeded")
                                        .font(.labelSM)
                                        .foregroundColor(.tombudgetOnSurfaceVariant)
                                }
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .tombudgetPrimary))
                    }
                }
                
                // Daily Spending Alert
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Daily Spending")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        Toggle(isOn: $dailyAlertEnabled) {
                            HStack(spacing: 12) {
                                Image(systemName: "bell.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.tombudgetPrimary)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Daily Threshold")
                                        .font(.bodyLG)
                                        .foregroundColor(.tombudgetOnSurface)
                                    Text("Notify when daily spending reaches threshold")
                                        .font(.labelSM)
                                        .foregroundColor(.tombudgetOnSurfaceVariant)
                                }
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .tombudgetPrimary))
                        
                        if dailyAlertEnabled {
                            Divider()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Threshold: \(Int(threshold))%")
                                    .font(.labelSM)
                                    .foregroundColor(.tombudgetOnSurfaceVariant)
                                
                                Slider(value: $threshold, in: 50...100, step: 5)
                                    .tint(.tombudgetPrimary)
                            }
                        }
                    }
                }
                
                // Congratulations
                GlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.tombudgetSecondary)
                            Text("Congratulations")
                                .font(.headlineMD)
                                .foregroundColor(.tombudgetOnSurface)
                        }
                        
                        Text("Get notified when you respect your budget for the month")
                            .font(.bodySM)
                            .foregroundColor(.tombudgetOnSurfaceVariant)
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
}
