//
//  AnalyticsProviderProtocol.swift
//  NubankShortener
//
//  Created by Andre  Haas on 09/06/26.
//

import Foundation

enum AnalyticsEvents {
  case actionButton(AnalyticsActions)
  case shortenSuccess(alias: String)  // claro: encurtou com sucesso
  case shortenFailed(reason: String)  // claro: falhou e por quê
  case invalidURL                     // claro: URL inválida
}

enum AnalyticsActions: String {
  case actionButtonTapped = "action-button-tapped"
  case linkTapped = "link-tapped"
  case copieTapped = "copie-tapped"
}

protocol AnalyticsProviderProtocol {
  func track(_ event: AnalyticsEvents)
}

final class AnalyticsProvider: AnalyticsProviderProtocol {
  private let queue = DispatchQueue(label: "com.nubank.analyticsProvider")
  let provider: AnalyticsProviderRemoteProtocol
  
  init(provider: AnalyticsProviderRemoteProtocol) {
    self.provider = provider
  }
  
  func track(_ event: AnalyticsEvents) {
    queue.async {
      self.provider.send(event: event)
    }
  }
}

protocol AnalyticsProviderRemoteProtocol {
  func send(event: AnalyticsEvents)
}

final class AnalyticsProviderRemote: AnalyticsProviderRemoteProtocol {
  
  func send(event: AnalyticsEvents) {
    print("AnalyticsProviderRemote => \(event)")
  }
}
