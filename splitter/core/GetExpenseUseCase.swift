protocol GetExpenseUseCase {
    func invoke(expenseId: String) -> Expense?
}

class GetExpenseUseCaseImpl: GetExpenseUseCase {
    let persistenceGateway: PersistenceGateway

    init(persistenceGateway: PersistenceGateway) {
        self.persistenceGateway = persistenceGateway
    }

    func invoke(expenseId: String) -> Expense? {
        return persistenceGateway.findExpense(expenseId: expenseId)
    }
}
