class FakePersitence: PersistenceGateway {
    func createExpense(expense: Expense) -> String {
        return ""
    }

    func findExpense(expenseId: String) -> Expense? {
        return Expense()
    }

    func findAll() -> [Expense] {
        return [Expense]()
    }
}
