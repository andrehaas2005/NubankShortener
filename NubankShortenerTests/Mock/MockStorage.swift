//
//  MockStorage.swift
//  NubankShortener
//
//  Created by Andre  Haas on 08/06/26.
//

import Foundation
import NubankShortener

final class MockStorage: LocalStorageProtocol {
  var items: [AliasResponse] = []
  
  func save(_ items: [NubankShortener.AliasResponse]) {
    self.items = items
  }
  
  func fetch() -> [NubankShortener.AliasResponse] {
    items
  }
  
  func removeAll() {
    items = []
  }

}
