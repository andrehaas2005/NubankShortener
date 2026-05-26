import XCTest

final class NubankShortenerUITests: XCTestCase {
  
  override func setUpWithError() throws {
    continueAfterFailure = false
    
  }
  
  override func tearDownWithError() throws {

  }
  func test_validURL_shouldDisplayHistoryItem() {

      let app = XCUIApplication()
      app.launch()
    app/*@START_MENU_TOKEN@*/.otherElements["CardView"]/*[[".otherElements",".containing(.staticText, identifier: \"Encurtar\")",".containing(.button, identifier: \"PrimaryButton\")",".otherElements[\"CardView\"]"],[[[-1,3],[-1,0,1]],[[-1,3],[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
    
      let textField = app.textFields["urlTextField"]
      textField.tap()
      textField.typeText("https://google.com")

      app.buttons["PrimaryButton"].tap()

      let historyCell = app.cells["ShortenerCell"]

      XCTAssertTrue(
          historyCell.waitForExistence(timeout: 10)
      )
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
    
    let alert = app.alerts["Ops"]

    XCTAssertTrue(alert.staticTexts["URL inválida. Verifique o formato."].exists)
    XCTAssertTrue(alert.staticTexts["URL inválida. Verifique o formato."].waitForExistence(timeout: 10))
    
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
