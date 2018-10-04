import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let objectLocator = ProductionObjectLocator()

        if ProcessInfo.processInfo.arguments.contains("UITests") {
            // Mock persistence
        }
        objectLocator.addObject(object: SaveExpenseUseCaseImpl(), t: SaveExpenseUseCase.self)
        objectLocator.addObject(object: GroupExpensesPresenter(saveExpenseUseCase: objectLocator.getObject()!))

        guard let rootViewController = GroupExpensesViewController.storyboardInstance(objectLocator: objectLocator) else {
            fatalError("Unable to instanciate GroupExpensesViewController")
        }

        let navigationController = UINavigationController(rootViewController: rootViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
