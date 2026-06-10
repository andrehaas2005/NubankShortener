//
//  FeatureFlagRemoteProvider.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//

import Foundation

final class FeatureFlagRemoteProvider: FeatureFlagRemoteProviderProtocol {
  
  private let queue = DispatchQueue(label: "com.nubank.featureFlagRemoteProvider")
  private let provider = UserDefaults.standard
  
  init () {
    setup()
  }
  private func setup() {
    queue.async {
      self.provider.register(defaults: [FeatureFlag.isHistoricoEnabled.rawValue : true])
    }
  }
  func getValue(forKey key: String) -> Bool {
    queue.sync {
      provider.bool(forKey: key)
    }
  }
}
