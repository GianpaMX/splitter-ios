import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let objectLocator = ObjectLocatorImpl()

        if ProcessInfo.processInfo.arguments.contains("UITests") {
            objectLocator.addObject(
                object: FakePersitence(),
                t: PersistenceGateway.self)
        } else {
            objectLocator.addObject(
                object: CoreDataPersistence(container: persistentContainer),
                t: PersistenceGateway.self
            )
        }
        objectLocator.addObject(
            object: SaveExpenseUseCaseImpl(persistenceGateway: objectLocator.getObject()!),
            t: SaveExpenseUseCase.self
        )
        objectLocator.addObject(
            object: GetExpensesUseCaseImpl(persistenceGateway: objectLocator.getObject()!),
            t: GetExpensesUseCase.self
        )
        objectLocator.addObject(
            object: GetExpenseUseCaseImpl(persistenceGateway: objectLocator.getObject()!),
            t: GetExpenseUseCase.self
        )
        objectLocator.addObject(object: GroupExpensesPresenter(
            saveExpenseUseCase: objectLocator.getObject()!,
            getExpensesUseCase: objectLocator.getObject()!)
        )
        objectLocator.addObject(object: ExpensePresenter(
            getExpenseUseCase: objectLocator.getObject()!,
            saveExpenseUseCase: objectLocator.getObject()!)
        )

        guard let rootViewController = GroupExpensesViewController.storyboardInstance(objectLocator: objectLocator) else {
            fatalError("Unable to instanciate GroupExpensesViewController")
        }

        let navigationController = UINavigationController(rootViewController: rootViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
