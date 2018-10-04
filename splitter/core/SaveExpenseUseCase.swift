protocol SaveExpenseUseCase {
    func invoke(expense: Expense) -> Expense
}

class SaveExpenseUseCaseImpl: SaveExpenseUseCase {
    func invoke(expense: Expense) -> Expense {
        return expense
    }
}
