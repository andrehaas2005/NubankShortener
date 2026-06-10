//
//  FeatureFlagRemoteProviderProtocol.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//

import Foundation

protocol FeatureFlagRemoteProviderProtocol {
  func getValue(forKey key: String) -> Bool
}
