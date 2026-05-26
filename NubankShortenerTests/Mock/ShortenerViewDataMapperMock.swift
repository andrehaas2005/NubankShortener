import Foundation
import Core
@testable import NubankShortener

final class ShortenerViewDataMapperMock: ShortenerViewDataMapperDelegate {

  
  var ui: [ShortenerUIModel] = []
  
  func toUIModel(_ domain: Core.AliasResponse) -> NubankShortener.ShortenerUIModel {
    ShortenerUIModel.fixed()
  }
  
  func formatAlias(_ alias: String) -> String {
    alias
  }
  
  func shortenDisplay(_ url: String, limit: Int) -> String {
    url
  }
  
  func toUIModels(_ list: [Core.AliasResponse]) -> [NubankShortener.ShortenerUIModel] {
    ui
  }
}
