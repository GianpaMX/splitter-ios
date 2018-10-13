import XCTest

class ExpenseViewControllerTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("UITests")
        app.launch()
        app.tables.cells.element(boundBy: 0).tap()
    }

    func testBackButton() {
        app.navigationBars.buttons.element(boundBy: 0).tap()

        XCTAssert(app.navigationBars["Expenses"].exists)
    }
}
