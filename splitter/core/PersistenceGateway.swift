protocol PersistenceGateway {
    func createExpense(expense: Expense) -> String
    func findExpense(expenseId: String) -> Expense?
    func findAll() -> [Expense]
    func updateExpense(expense: Expense)
}
