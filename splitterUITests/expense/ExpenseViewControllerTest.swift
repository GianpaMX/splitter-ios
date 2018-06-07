import XCTest

class ExpenseViewControllerTest: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("ExpenseViewController")
        app.launch()
    }

    func testEmpty() {
    }
}
