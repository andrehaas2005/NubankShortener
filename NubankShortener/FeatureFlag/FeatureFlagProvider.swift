//
//  FeatureFlagProvider.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//
import Foundation

final class FeatureFlagProvider: FeatureFlagProviderProtocol {

  let provider: FeatureFlagRemoteProviderProtocol
  
  init(provider: FeatureFlagRemoteProviderProtocol) {
    self.provider = provider
  }
  
  func fetchRemoteConfig(completion: @escaping () -> Void) {
    // com Firebase seria
    // RemoteConfig.remoteConfig().fetchAndActive {_, _ in completion() }
    
    // com UserDefaults ( mock local ) - simula delay de rede
    DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
      completion()
    }
  }
  
  func isEnabled(_ flag: FeatureFlag) -> Bool {
    provider.getValue(forKey: flag.rawValue)
  }
}
