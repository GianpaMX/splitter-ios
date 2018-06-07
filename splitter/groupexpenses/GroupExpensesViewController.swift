import UIKit

private let cellIdentifier = "ExpenseTableViewCell"

class GroupExpensesViewController: UITableViewController {
    //MARK: Properties
    @IBOutlet weak var expensesTableView: UITableView!

    var expenses = [ExpenseItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

        expenses.append(ExpenseItem(id: 1, title: "Hello", total: 123.45))
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
