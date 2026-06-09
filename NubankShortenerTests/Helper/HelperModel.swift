//
//  HelperModel.swift
//  NubankShortener
//
//  Created by Andre  Haas on 08/06/26.
//

import Foundation
import NubankShortener
  
  
extension ShortenerUIModel {
  static func fixed() ->ShortenerUIModel {
    ShortenerUIModel(id: UUID(),
                     alias: "abc123",
                     short: "https://short.com",
                     original: "https://full.com",
                     displayTitle: "display Title",
                     displaySubtitle: "display Subtitle")
  }
}

extension AliasResponse {
  static func fixed() -> AliasResponse {
    return .init(
      alias: "abc123",
      links: .init(
        self: "https://full.com",
        short: "https://short.com"
      )
    )
  }
}
