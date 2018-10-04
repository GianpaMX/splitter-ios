class GroupExpensesPresenter {
    let saveExpenseUseCase: SaveExpenseUseCase
    
    var view: GroupExpensesPresenterView?

    init(saveExpenseUseCase: SaveExpenseUseCase, view: GroupExpensesPresenterView? = nil) {
        self.saveExpenseUseCase = saveExpenseUseCase
        
        self.view = view
    }

    func addExpense() {
        view?.onExpenseAdded(expenseId: 1)
    }

}

protocol GroupExpensesPresenterView {
    func onExpenseAdded(expenseId: Int)
}
