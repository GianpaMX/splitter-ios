import UIKit

class PayerViewController: UIViewController {
    static func storyboardInstance() -> PayerViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? PayerViewController

        return viewController
    }
}
