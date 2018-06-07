import UIKit

class ExpenseViewController: UIViewController {
    
    static func storyboardInstance() -> ExpenseViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? ExpenseViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
