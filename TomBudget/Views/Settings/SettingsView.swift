import SwiftUI

struct SettingsView: View {
    @State private var isDarkMode = false
    @State private var faceIDEnabled = true
    @State private var iCloudSync = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Header
                GlassCard {
                    HStack(spacing: 16) {
                        Circle()
                            .fill(Color.tombudgetPrimary.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 28))
                                    .foregroundColor(.tombudgetPrimary)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Thomas")
                                .font(.headlineLG)
                                .foregroundColor(.tombudgetOnSurface)
                            Text("thomas@example.com")
                                .font(.labelSM)
                                .foregroundColor(.tombudgetOnSurfaceVariant)
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "pencil")
                                .font(.system(size: 18))
                                .foregroundColor(.tombudgetPrimary)
                        }
                    }
                }
                
                // Appearance
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Appearance")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        Toggle(isOn: $isDarkMode) {
                            HStack(spacing: 12) {
                                Image(systemName: "moon.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.tombudgetSecondary)
                                Text("Dark Mode")
                                    .font(.bodyLG)
                                    .foregroundColor(.tombudgetOnSurface)
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .tombudgetPrimary))
                    }
                }
                
                // Security
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Security")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        Toggle(isOn: $faceIDEnabled) {
                            HStack(spacing: 12) {
                                Image(systemName: "faceid")
                                    .font(.system(size: 20))
                                    .foregroundColor(.tombudgetPrimary)
                                Text("Face ID")
                                    .font(.bodyLG)
                                    .foregroundColor(.tombudgetOnSurface)
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .tombudgetPrimary))
                    }
                }
                
                // iCloud Sync
                GlassCard {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Data")
                            .font(.headlineMD)
                            .foregroundColor(.tombudgetOnSurface)
                        
                        Toggle(isOn: $iCloudSync) {
                            HStack(spacing: 12) {
                                Image(systemName: "icloud.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.tombudgetSecondary)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("iCloud Sync")
                                        .font(.bodyLG)
                                        .foregroundColor(.tombudgetOnSurface)
                                    Text("Sync data across devices")
                                        .font(.labelSM)
                                        .foregroundColor(.tombudgetOnSurfaceVariant)
                                }
                            }
                        }
                        .toggleStyle(SwitchToggleStyle(tint: .tombudgetPrimary))
                        
                        Divider()
                        
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "arrow.clockwise")
                                    .font(.system(size: 18))
                                Text("Reset All Data")
                                    .font(.bodyLG)
                                Spacer()
                            }
                            .foregroundColor(.tombudgetError)
                        }
                    }
                }
                
                // About
                GlassCard {
                    VStack(spacing: 12) {
                        HStack {
                            Text("Version")
                                .font(.bodyLG)
                                .foregroundColor(.tombudgetOnSurface)
                            Spacer()
                            Text("1.0.0")
                                .font(.labelSM)
                                .foregroundColor(.tombudgetOnSurfaceVariant)
                        }
                        
                        Divider()
                        
                        Button(action: {}) {
                            HStack {
                                Text("Help & Support")
                                    .font(.bodyLG)
                                    .foregroundColor(.tombudgetOnSurface)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14))
                                    .foregroundColor(.tombudgetOnSurfaceVariant)
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
}
