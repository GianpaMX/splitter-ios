class GroupExpensesPresenter {
    let saveExpenseUseCase: SaveExpenseUseCase
    let getExpensesUseCase: GetExpensesUseCase

    var view: GroupExpensesPresenterView?

    init(
        saveExpenseUseCase: SaveExpenseUseCase,
        getExpensesUseCase: GetExpensesUseCase,
        view: GroupExpensesPresenterView? = nil
    ) {
        self.saveExpenseUseCase = saveExpenseUseCase
        self.getExpensesUseCase = getExpensesUseCase

        self.view = view
    }

    func addExpense() {
        let expense = saveExpenseUseCase.invoke(expense: Expense())
        view?.onExpenseAdded(expenseId: expense.id)
    }

    func loadExpenses() {
        let expenses = getExpensesUseCase.invoke()

        view?.showExpenses(expenseItems: expenses.map { $0.toExpenseItem() })
    }
}

protocol GroupExpensesPresenterView {
    func onExpenseAdded(expenseId: String)
    func showExpenses(expenseItems: [ExpenseItem])
}

fileprivate extension Expense {
    func toExpenseItem() -> ExpenseItem {
        return ExpenseItem(id: id, title: title, total: 0.0)
    }
}
