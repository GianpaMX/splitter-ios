import UIKit

class ExpenseViewController: UIViewController, ExpensePresenterView {
    @IBOutlet weak var titleTextField: UITextField!

    var expenseId: String = ""
    var presenter: ExpensePresenter? = nil

    static func storyboardInstance(objectLocator: ObjectLocator, expenseId: String = "") -> ExpenseViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? ExpenseViewController

        viewController?.presenter = objectLocator.getObject()
        viewController?.expenseId = expenseId

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.view = self
        if(!expenseId.isEmpty) {
            DispatchQueue.global(qos: .userInitiated).async {
                self.presenter?.loadExpense(expenseId: self.expenseId)
            }
        }

        navigationController?.navigationBar.prefersLargeTitles = false

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(add))
    }

    @objc func add() {
    }

    func showExpense(expenseModel: ExpenseModel) {
        DispatchQueue.main.async {
            self.titleTextField.text = expenseModel.title
        }
    }
}
