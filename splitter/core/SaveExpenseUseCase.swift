protocol SaveExpenseUseCase {
    func invoke(expense: Expense) -> Expense
}

class SaveExpenseUseCaseImpl: SaveExpenseUseCase {
    let persistenceGateway: PersistenceGateway

    init(persistenceGateway: PersistenceGateway) {
        self.persistenceGateway = persistenceGateway
    }

    func invoke(expense: Expense) -> Expense {
        var expense = expense

        if(expense.id.isEmpty) {
            expense.id = persistenceGateway.createExpense(expense: expense)
        }

        return expense
    }
}
