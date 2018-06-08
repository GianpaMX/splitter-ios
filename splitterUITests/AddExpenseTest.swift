import XCTest

class AddExpenseTest: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("UITests")
        app.launch()
    }

    func testAddExpense() {
        XCUIApplication().navigationBars["Expenses"].buttons["Add"].tap()
    }
}
