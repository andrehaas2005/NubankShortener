import XCTest

final class NubankShortenerUITests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func test_invalidURL_shouldShowErrorAlert() {
    
    let app = XCUIApplication()
    app.launch()
    
    app/*@START_MENU_TOKEN@*/.otherElements["CardView"]/*[[".otherElements",".containing(.staticText, identifier: \"Encurtar\")",".containing(.button, identifier: \"PrimaryButton\")",".otherElements[\"CardView\"]"],[[[-1,3],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
    app.typeText("qualquer coisa aqui, sem ser url valida")
    
    let textField = app.textFields["urlTextField"]
    XCTAssertTrue(textField.exists)
    
    textField.tap()
    textField.typeText("texto invalido")
    
    let shortenButton = app.buttons["PrimaryButton"]
    XCTAssertTrue(shortenButton.exists)
    
    shortenButton.tap()
    
    let alert = app.alerts["Erro"]

    XCTAssertTrue(app.staticTexts["URL inválida"].waitForExistence(timeout: 2))
    XCTAssertTrue(app.staticTexts["URL inválida"].exists)
    
    alert.buttons["OK"].tap()
  }
  
  @MainActor
  func testLaunchPerformance() throws {
    // This measures how long it takes to launch your application.
    measure(metrics: [XCTApplicationLaunchMetric()]) {
      XCUIApplication().launch()
    }
  }
}
