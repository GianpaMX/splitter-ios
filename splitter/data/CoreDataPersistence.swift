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
        return findManagedObjectById(id: expenseId)?.toExpense()
    }

    private func findManagedObjectById(id: String) -> NSManagedObject? {
        let extractedExpr: NSPersistentStoreCoordinator = container.persistentStoreCoordinator
        if let managedObjectId = extractedExpr.managedObjectID(forURIRepresentation: URL(string: id)!) {
            return container.viewContext.object(with: managedObjectId)
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

    func updateExpense(expense: Expense) {
        let managedObject = findManagedObjectById(id: expense.id)
        managedObject?.setValue(expense.title, forKey: "title")

        do {
            try container.viewContext.save()
        } catch {
            print("Failed saving")
        }
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
