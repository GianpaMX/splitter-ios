
import XCTest
import Cuckoo

@testable import splitter

class ExpensePresenterTests: XCTestCase {
    let saveExpenseUseCase = MockSaveExpenseUseCase()
    let getExpenseUseCase = MockGetExpenseUseCase()
    let view = MockExpensePresenterView()

    var expensePresenter: ExpensePresenter? = nil

    override func setUp() {
        super.setUp()
        expensePresenter = ExpensePresenter(
            getExpenseUseCase: getExpenseUseCase,
            saveExpenseUseCase: saveExpenseUseCase,
            view: view
        )
    }

    func testLoadExpense() {
        stub(getExpenseUseCase) { stub in
            when(stub.invoke(expenseId: anyString())).thenReturn(Expense(id: "ANY ID"))
        }
        stub(view) { stub in
            when(stub.showExpense(expenseModel: any())).thenDoNothing()
        }

        expensePresenter?.loadExpense(expenseId: "ANY ID")

        verify(view).showExpense(expenseModel: any())
    }

    func testSaveExpense() {
        stub(saveExpenseUseCase) { stub in
            when(stub.invoke(expense: any())).thenReturn(Expense(id: "ANY ID"))
        }

        expensePresenter?.saveExpense(expenseModel: ExpenseModel())

        verify(saveExpenseUseCase).invoke(expense: any())
    }
}
