import CoreData

class CoreDataPersistence: PersistenceGateway {
    let container: NSPersistentContainer

    init(container: NSPersistentContainer) {
        self.container = container
    }

    func createExpense(expense: Expense) -> String {
        let entity = NSEntityDescription.entity(forEntityName: "ExpenseDataModel", in: container.viewContext)
        let managedObject = NSManagedObject(entity: entity!, insertInto: container.viewContext)
        managedObject.setValue(expense.title, forKey: "title")

        do {
            try container.viewContext.save()
        } catch {
            print("Failed saving")
        }

        return managedObject.objectID.uriRepresentation().absoluteString
    }

    func findExpense(expenseId: String) -> Expense? {
        let extractedExpr: NSPersistentStoreCoordinator = container.persistentStoreCoordinator
        if let managedObjectId = extractedExpr.managedObjectID(forURIRepresentation: URL(string: expenseId)!) {
            return container.viewContext.object(with: managedObjectId).toExpense()
        }
        return nil
    }

    func findAll() -> [Expense] {
        var expenses = [Expense]()

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "ExpenseDataModel")
        request.returnsObjectsAsFaults = false

        do {
            let result = try container.viewContext.fetch(request)
            for managedObject in result as! [NSManagedObject] {
                expenses.append(managedObject.toExpense())
            }
        } catch {
            print("Failed")
        }

        return expenses
    }
}

fileprivate extension NSManagedObject {
    func toExpense() -> Expense {
        var expense = Expense()
        expense.id = self.objectID.uriRepresentation().absoluteString
        expense.title = self.value(forKey: "title") as? String ?? ""
        return expense
    }
}
