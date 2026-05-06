import SwiftUI
import CoreData

@main
struct TomBudgetApp: App {
    let persistenceController = CoreDataStack.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
