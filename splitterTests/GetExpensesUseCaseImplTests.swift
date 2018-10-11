import XCTest
import Cuckoo

@testable import splitter

class GetExpensesUseCaseImplTests: XCTestCase {
    let persistenceGateway = MockPersistenceGateway()

    var getExpensesUseCaseImpl: GetExpensesUseCaseImpl? = nil

    override func setUp() {
        super.setUp()
        getExpensesUseCaseImpl = GetExpensesUseCaseImpl(persistenceGateway: persistenceGateway)
    }

    func testSucessful() {
        stub(persistenceGateway) { stub in
            when(stub.findAll()).thenReturn([Expense]())
        }

        let result = getExpensesUseCaseImpl?.invoke()

        XCTAssertEqual(0, result?.count)
    }
}
