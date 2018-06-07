import UIKit

private let cellIdentifier = "ExpenseTableViewCell"

class GroupExpensesViewController: UITableViewController {
    //MARK: Properties
    @IBOutlet weak var expensesTableView: UITableView!

    var expenses = [ExpenseItem]()

    static func storyboardInstance() -> GroupExpensesViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? GroupExpensesViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Expenses"

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addExpense))

        expenses.append(ExpenseItem(id: 1, title: "Hello", total: 123.45))
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    @objc func addExpense() {
        guard let expenseViewController = ExpenseViewController.storyboardInstance() else {
            fatalError("Unable to instanciate ExpenseViewController")
        }
        navigationController?.pushViewController(expenseViewController, animated: true)
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
}