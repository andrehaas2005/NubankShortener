//
//  PedingQueueManager.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//

import Foundation
import Network

final class PedingQueueManager: PendingQueueManagerProtocol {
  
  private let storage: PendingStorageProtocol
  private let monitor: NWPathMonitor
  private let queue = DispatchQueue(label: "com.nubank.pedingQueue")
  var onConnectionRestored: (() -> Void)?
  
  init(storage: PendingStorageProtocol) {
    self.storage = storage
    self.monitor = NWPathMonitor()
    setupMonitor()
  }
  
  func setupMonitor() {
    monitor.pathUpdateHandler = { [weak self] path in
      print("Setup Monitor Status: \(path.status)")
      if path.status == .satisfied {
        self?.onConnectionRestored?()
      }
    }
    monitor.start(queue: queue)
  }
  
  func enqueue(_ url: String) {
    storage.savePending(url)
  }
  
  func processsQueue(completion: @escaping (String) -> Void) {
    let pending = storage.fetchPending()
    pending.forEach { completion($0)}
    storage.clearPending()
  }

  func clearQueue() {
    storage.clearPending()
  }
  
  deinit {
    monitor.cancel()
  }
}
