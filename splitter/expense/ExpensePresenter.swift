class ExpensePresenter {
    let getExpenseUseCase: GetExpenseUseCase

    var view: ExpensePresenterView?

    init(
        getExpenseUseCase: GetExpenseUseCase,
        view: ExpensePresenterView? = nil
    ) {
        self.getExpenseUseCase = getExpenseUseCase

        self.view = view
    }

    func loadExpense(expenseId: String) {
        if let expense = getExpenseUseCase.invoke(expenseId: expenseId) {
            view?.showExpense(expenseModel: expense.toExpenseModel())
        }
    }
}

protocol ExpensePresenterView {
    func showExpense(expenseModel: ExpenseModel)
}

fileprivate extension Expense {
    func toExpenseModel() -> ExpenseModel {
        var expenseModel = ExpenseModel()
        expenseModel.id = id
        expenseModel.title = title
        return expenseModel
    }
}
