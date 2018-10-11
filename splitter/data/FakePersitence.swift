class FakePersitence: PersistenceGateway {
    func updateExpense(expense: Expense) {
        // Do nothing
    }

    func createExpense(expense: Expense) -> String {
        return ""
    }

    func findExpense(expenseId: String) -> Expense? {
        return Expense()
    }

    func findAll() -> [Expense] {
        return [Expense(id: "ANY-ID", title: "Any title")]
    }
}
