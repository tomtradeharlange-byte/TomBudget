import CoreData

@objc(TransactionEntity)
public class TransactionEntity: NSManagedObject {
}

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
