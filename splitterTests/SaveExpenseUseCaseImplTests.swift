import XCTest
@testable import splitter

class SaveExpenseUseCaseImplTests: XCTestCase {
    
    var saveExpenseUseCaseImpl : SaveExpenseUseCaseImpl? = nil
    
    override func setUp() {
        super.setUp()
        saveExpenseUseCaseImpl = SaveExpenseUseCaseImpl()
    }
    func testInvoke() {
        saveExpenseUseCaseImpl?.invoke(expense: Expense())
    }
}
