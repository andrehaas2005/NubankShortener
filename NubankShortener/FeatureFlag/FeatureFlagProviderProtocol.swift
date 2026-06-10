//
//  FeatureFlagProviderProtocol.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//
import Foundation

protocol FeatureFlagProviderProtocol {
  func isEnabled(_ flag: FeatureFlag) -> Bool
  func fetchRemoteConfig(completion: @escaping () -> Void)
}
