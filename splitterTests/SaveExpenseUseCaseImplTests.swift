import XCTest
import Cuckoo

@testable import splitter

class SaveExpenseUseCaseImplTests: XCTestCase {
    let persistenceGateway = MockPersistenceGateway()

    var saveExpenseUseCaseImpl: SaveExpenseUseCaseImpl? = nil

    override func setUp() {
        super.setUp()
        saveExpenseUseCaseImpl = SaveExpenseUseCaseImpl(persistenceGateway: persistenceGateway)
    }

    func testCreateExpense() {
        let expectedId = "ANY ID"
        stub(persistenceGateway) { stub in
            when(stub.createExpense(expense: any())).thenReturn(expectedId)
        }

        let result = saveExpenseUseCaseImpl?.invoke(expense: Expense())

        XCTAssertEqual(expectedId, result?.id)
    }

    func testUpdateExpense() {
        let existingExpense = Expense(id: "ANY ID")
        stub(persistenceGateway) { stub in
            when(stub.updateExpense(expense: any())).thenDoNothing()
        }

        let _ = saveExpenseUseCaseImpl?.invoke(expense: existingExpense)

        verify(persistenceGateway).updateExpense(expense: any())
    }
}
