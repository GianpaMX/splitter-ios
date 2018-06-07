import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {


        guard let rootViewController = getRootViewController() else {
            fatalError("Unable to instanciate RootViewController")
        }
        let navigationController = UINavigationController(rootViewController: rootViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }

    func getRootViewController() -> UIViewController? {
        if(ProcessInfo.processInfo.arguments.contains(String(describing: ExpenseViewController.self))) {
            return ExpenseViewController.storyboardInstance()
        }

        return GroupExpensesViewController.storyboardInstance()
    }
}
