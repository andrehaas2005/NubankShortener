//
//  LocalStorage.swift
//  NubankShortener
//
//  Created by Andre  Haas on 08/06/26.
//

import Foundation


final class LocalStorage: LocalStorageProtocol {
  
  private enum Keys {
    static let history: String = "shorterner_history"
  }
  
  private let key = Keys.history
  private let queue = DispatchQueue(label: "com.nubank.localstorage")
  
  func save(_ items: [AliasResponse]) {
    queue.async {
      guard let data = try? JSONEncoder().encode(items) else { return }
      UserDefaults.standard.set(data, forKey: self.key)
    }
  }
  
  func fetch() -> [AliasResponse] {
    queue.sync {
      guard let data = UserDefaults.standard.data(forKey: key) else { return [] }
      let alias = try? JSONDecoder().decode([AliasResponse].self, from: data)
      return ( alias ?? [])
    }
  }
  
  func fetch(page: Int, pageSize: Int) -> [AliasResponse] {
    queue.sync {
      let start = page * pageSize
      guard let data = UserDefaults.standard.data(forKey: key),
            let all = try? JSONDecoder().decode([AliasResponse].self, from: data),
            start < all.count else { return [] }
      
      let end = min(start + pageSize, all.count)
      return Array(all[start..<end])
    }
  }
  
  
  func removeAll() {
    queue.async {
      UserDefaults.standard.removeObject(forKey: self.key)
    }
  }
}
