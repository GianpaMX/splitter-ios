import XCTest

class GroupExpensesViewControllerTest: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments.append("GroupExpensesViewController")
        app.launch()
    }

    func testEmpty() {
    }
}
