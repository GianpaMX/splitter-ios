import UIKit
import CoreData

private let cellIdentifier = "ExpenseTableViewCell"

class GroupExpensesViewController: UITableViewController, GroupExpensesPresenterView {
    var objectLocator: ObjectLocator? = nil
    var presenter: GroupExpensesPresenter? = nil

    var expenses = [ExpenseItem]()

    static func storyboardInstance(objectLocator: ObjectLocator) -> GroupExpensesViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as? GroupExpensesViewController

        viewController?.objectLocator = objectLocator
        viewController?.presenter = objectLocator.getObject()

        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.view = self

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Expenses"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addExpense))

        DispatchQueue.global(qos: .userInitiated).async {
            self.presenter?.loadExpenses()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ExpenseTableViewCell else {
            fatalError("The dequeued cell is not an instance of ExpenseTableViewCell")
        }

        let expense = expenses[indexPath.row]
        cell.titleLabel.text = expense.title

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        launchExpenseViewController(expenseId: self.expenses[indexPath.row].id)
    }

    @objc func addExpense() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.presenter?.addExpense()
        }
    }

    func onExpenseAdded(expenseId: String) {
        DispatchQueue.main.async {
            self.launchExpenseViewController(expenseId: expenseId)
        }
    }

    func showExpenses(expenseItems: [ExpenseItem]) {
        DispatchQueue.main.async {
            self.expenses = expenseItems
            self.tableView.reloadData()
        }
    }

    func launchExpenseViewController(expenseId: String) {
        guard let expenseViewController = ExpenseViewController.storyboardInstance(
            objectLocator: self.objectLocator!,
            expenseId: expenseId
        ) else {
            fatalError("Unable to instanciate ExpenseViewController")
        }
        self.navigationController?.pushViewController(expenseViewController, animated: true)
    }
}
