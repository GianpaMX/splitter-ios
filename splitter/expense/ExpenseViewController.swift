import UIKit

class ExpenseViewController: UIViewController, ExpensePresenterView {
    @IBOutlet weak var titleTextField: UITextField!

    var expenseId = ""
    var expenseModel = ExpenseModel()
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

    override func viewWillDisappear(_ animated: Bool) {
        self.expenseModel.title = self.titleTextField.text ?? ""
        DispatchQueue.global(qos: .userInitiated).async {
            self.presenter?.saveExpense(expenseModel: self.expenseModel)
        }
    }

    @objc func add() {
        guard let payerViewController = PayerViewController.storyboardInstance() else {
            fatalError("Unable to instanciate PayerViewController")
        }
        payerViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(payerViewController, animated: true)
    }

    func showExpense(expenseModel: ExpenseModel) {
        DispatchQueue.main.async {
            self.expenseModel = expenseModel
            self.titleTextField.text = expenseModel.title
        }
    }
}
