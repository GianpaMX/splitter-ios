protocol GetExpensesUseCase {
    func invoke() -> [Expense]
}

class GetExpensesUseCaseImpl: GetExpensesUseCase {
    let persistenceGateway: PersistenceGateway

    init(persistenceGateway: PersistenceGateway) {
        self.persistenceGateway = persistenceGateway
    }

    func invoke() -> [Expense] {
        return persistenceGateway.findAll()
    }
}
