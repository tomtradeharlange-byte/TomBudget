import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            // Background
            Color.tombudgetBackground
                .ignoresSafeArea()
            
            // Main Content
            TabView(selection: $selectedTab) {
                DashboardView()
                    .tabItem {
                        Image(systemName: "chart.pie.fill")
                        Text("Dashboard")
                    }
                    .tag(0)
                
                TransactionsView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Transactions")
                    }
                    .tag(1)
                
                AddTransactionView()
                    .tabItem {
                        Image(systemName: "plus.circle.fill")
                        Text("Add")
                    }
                    .tag(2)
                
                GoalsView()
                    .tabItem {
                        Image(systemName: "flag.fill")
                        Text("Goals")
                    }
                    .tag(3)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
                    .tag(4)
            }
            .accentColor(.tombudgetPrimary)
        }
    }
}
