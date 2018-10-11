import XCTest
import Cuckoo

@testable import splitter

class GetExpenseUseCaseImplTests: XCTestCase {
    let persistenceGateway = MockPersistenceGateway()

    var getExpenseUseCaseImpl: GetExpenseUseCaseImpl? = nil

    override func setUp() {
        super.setUp()
        getExpenseUseCaseImpl = GetExpenseUseCaseImpl(persistenceGateway: persistenceGateway)
    }

    func testSucessful() {
        let expectedExpense = Expense()
        stub(persistenceGateway) { stub in
            when(stub.findExpense(expenseId: anyString())).thenReturn(expectedExpense)
        }

        let result = getExpenseUseCaseImpl?.invoke(expenseId: "ANY ID")

        XCTAssertEqual(expectedExpense, result)
    }
}
