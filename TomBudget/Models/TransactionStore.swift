import CoreData

extension TransactionEntity {
    static func fetchAll(context: NSManagedObjectContext) -> [TransactionEntity] {
        let request = TransactionEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return (try? context.fetch(request)) ?? []
    }
    
    static func create(amount: Double, category: String, date: Date, note: String?, isExpense: Bool, context: NSManagedObjectContext) -> TransactionEntity {
        let entity = TransactionEntity(context: context)
        entity.id = UUID()
        entity.amount = amount
        entity.category = category
        entity.date = date
        entity.note = note
        entity.isExpense = isExpense
        return entity
    }
}
