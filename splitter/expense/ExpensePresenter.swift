class ExpensePresenter {
    let getExpenseUseCase: GetExpenseUseCase
    let saveExpenseUseCase: SaveExpenseUseCase

    var view: ExpensePresenterView?

    init(
        getExpenseUseCase: GetExpenseUseCase,
        saveExpenseUseCase: SaveExpenseUseCase,
        view: ExpensePresenterView? = nil
    ) {
        self.getExpenseUseCase = getExpenseUseCase
        self.saveExpenseUseCase = saveExpenseUseCase

        self.view = view
    }

    func loadExpense(expenseId: String) {
        if let expense = getExpenseUseCase.invoke(expenseId: expenseId) {
            view?.showExpense(expenseModel: expense.toExpenseModel())
        }
    }

    func saveExpense(expenseModel: ExpenseModel) {
        let _ = saveExpenseUseCase.invoke(expense: expenseModel.toExpense())
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

fileprivate extension ExpenseModel {
    func toExpense() -> Expense {
        var expense = Expense()
        expense.id = id
        expense.title = title
        return expense
    }
}
