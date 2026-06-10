import Foundation

public struct UrlResponse: Codable, Equatable {
  public let url: String
  public init(url: String) {
    self.url = url
  }
}
