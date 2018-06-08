class GroupExpensesPresenter {
    let view: GroupExpensesPresenterView?

    init(view: GroupExpensesPresenterView?) {
        self.view = view
    }

    func addExpense() {
        view?.onExpenseAdded(expenseId: 1)
    }

}

protocol GroupExpensesPresenterView {
    func onExpenseAdded(expenseId: Int)
}
