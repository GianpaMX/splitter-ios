import XCTest
import Cuckoo

@testable import splitter

class GroupExpensesPresenterTests: XCTestCase {
    let saveExpenseUseCase = MockSaveExpenseUseCase()
    let getExpensesUseCase = MockGetExpensesUseCase()
    let view = MockGroupExpensesPresenterView()

    var groupExpensesPresenter: GroupExpensesPresenter? = nil

    override func setUp() {
        super.setUp()
        groupExpensesPresenter = GroupExpensesPresenter(
            saveExpenseUseCase: saveExpenseUseCase,
            getExpensesUseCase: getExpensesUseCase,
            view: view)
    }

    func testAddExpense() {
        stub(saveExpenseUseCase) { stub in
            when(stub.invoke(expense: any())).thenReturn(Expense(id: "ANY ID"))
        }
        stub(view) { stub in
            when(stub.onExpenseAdded(expenseId: anyString())).thenDoNothing()
        }

        groupExpensesPresenter?.addExpense()

        verify(view).onExpenseAdded(expenseId: anyString())
    }

    func testLoadExpenses() {
        let expectedElement = Expense(id: "ANY ID")
        stub(getExpensesUseCase) { stub in
            when(stub.invoke()).thenReturn([expectedElement])
        }
        stub(view) { stub in
            when(stub.showExpenses(expenseItems: any())).thenDoNothing()
        }

        groupExpensesPresenter?.loadExpenses()

        let captor = ArgumentCaptor<[ExpenseItem]>()
        verify(view).showExpenses(expenseItems: captor.capture())
        XCTAssertEqual(expectedElement.id, captor.value?[0].id)
    }
}
