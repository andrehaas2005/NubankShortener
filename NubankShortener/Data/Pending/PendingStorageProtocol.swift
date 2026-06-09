//
//  PedingStorageProtocol.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//

import Foundation

protocol PendingStorageProtocol {
  func savePending(_ url: String)
  func fetchPending() -> [String]
  func clearPending()
}
