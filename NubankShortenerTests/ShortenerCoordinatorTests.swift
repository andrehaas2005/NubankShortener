//
//  ShortenerCoordinatorTests.swift
//  NubankShortenerTests
//
//  Created by Andre Luis De Oliveira Amaral Haas on 25/05/26.
//
import XCTest
import Core
import Networking
@testable import NubankShortener

final class ShortenerCoordinatorTests: XCTestCase {
  var sut: ShortenerCoordinator!
  var router: DefaultRouterMock!
  
  override func setUp() {
    super.setUp()
    router = DefaultRouterMock()
    sut = ShortenerCoordinator(router: router)
  }
  
  
  func testShowErrore() throws {
    sut.showError(message: "Erro generico")
    XCTAssertEqual(router.presentControll, 1)
  }
  
  func test_openShortURL_external() {
    let alias = AliasResponse.fixed()
    sut.openShortURL(alias)
    XCTAssertTrue(UIApplication.shared.canOpenURL(URL(string: alias.links.short)!))
  }
  
  func test_showToast() {
    sut.showToast(in: UIViewController())
    XCTAssertEqual(router.showToastCall, 1)
    XCTAssertNotNil(router.controller)
  }
}
