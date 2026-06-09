//
//  PedingQueueManagerProtocol.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//

import Foundation

public protocol PendingQueueManagerProtocol {
  func enqueue(_ url: String)
  func processsQueue(completion: @escaping (String)-> Void)
  func clearQueue()
}
