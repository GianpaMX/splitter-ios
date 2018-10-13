import XCTest

class GroupExpensesViewControllerTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("UITests")
        app.launch()
    }

    func testAddExpense() {
        app.navigationBars["Expenses"].buttons["Add"].tap()

        XCTAssertEqual("Expenses", app.navigationBars.buttons.element(boundBy: 0).label)
    }

    func testViewExpense() {
        app.tables.cells.element(boundBy: 0).tap()

        XCTAssertEqual("Expenses", app.navigationBars.buttons.element(boundBy: 0).label)
    }
}
