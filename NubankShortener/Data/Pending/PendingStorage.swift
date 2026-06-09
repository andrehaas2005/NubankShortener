//
//  PendingStorage.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//

import Foundation

final class PendingStorage: PendingStorageProtocol {
  
  private enum Keys {
    static let pending = "shortener_pending_queue"
  }
  private let queue = DispatchQueue(label: "com.nubank.pendingStorage")
  
  func savePending(_ url: String) {
    queue.async {
      var current = self.readPending()
      current.append(url)
      UserDefaults.standard.set(current, forKey: Keys.pending)
    }
  }
  
  func fetchPending() -> [String] {
    queue.sync {
      self.readPending()
    }
  }
  
  private func readPending() -> [String] {
    UserDefaults.standard.stringArray(forKey: Keys.pending) ?? [String()]
  }
  
  func clearPending() {
    queue.async {
      UserDefaults.standard.removeObject(forKey: Keys.pending)
    }
  }
  
  
}
