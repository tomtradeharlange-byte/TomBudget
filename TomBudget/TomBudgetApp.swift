import SwiftUI
import CoreData

@main
struct TomBudgetApp: App {
    let persistentContainer = PersistentContainer.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.context)
        }
    }
}

class PersistentContainer {
    static let shared = PersistentContainer()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let model = CoreDataModel.createModel()
        let container = NSPersistentContainer(name: "TomBudget", managedObjectModel: model)
        
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Core Data error: \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}

class CoreDataModel {
    static func createModel() -> NSManagedObjectModel {
        let model = NSManagedObjectModel()
        
        let transactionEntity = NSEntityDescription()
        transactionEntity.name = "TransactionEntity"
        transactionEntity.managedObjectClassName = "TransactionEntity"
        
        let idAttribute = NSAttributeDescription()
        idAttribute.name = "id"
        idAttribute.attributeType = .transformableAttributeType
        idAttribute.isOptional = false
        
        let amountAttribute = NSAttributeDescription()
        amountAttribute.name = "amount"
        amountAttribute.attributeType = .doubleAttributeType
        amountAttribute.isOptional = false
        amountAttribute.defaultValue = 0.0
        
        let categoryAttribute = NSAttributeDescription()
        categoryAttribute.name = "category"
        categoryAttribute.attributeType = .stringAttributeType
        categoryAttribute.isOptional = false
        categoryAttribute.defaultValue = ""
        
        let dateAttribute = NSAttributeDescription()
        dateAttribute.name = "date"
        dateAttribute.attributeType = .dateAttributeType
        dateAttribute.isOptional = false
        
        let noteAttribute = NSAttributeDescription()
        noteAttribute.name = "note"
        noteAttribute.attributeType = .stringAttributeType
        noteAttribute.isOptional = true
        
        let isExpenseAttribute = NSAttributeDescription()
        isExpenseAttribute.name = "isExpense"
        isExpenseAttribute.attributeType = .booleanAttributeType
        isExpenseAttribute.isOptional = false
        isExpenseAttribute.defaultValue = true
        
        transactionEntity.properties = [idAttribute, amountAttribute, categoryAttribute, dateAttribute, noteAttribute, isExpenseAttribute]
        
        model.entities = [transactionEntity]
        
        return model
    }
}

@objc(TransactionEntity)
public class TransactionEntity: NSManagedObject {}

extension TransactionEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionEntity> {
        return NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var amount: Double
    @NSManaged public var category: String
    @NSManaged public var date: Date
    @NSManaged public var note: String?
    @NSManaged public var isExpense: Bool
}
