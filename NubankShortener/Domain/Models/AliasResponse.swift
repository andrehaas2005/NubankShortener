import Foundation

public struct AliasResponse: Codable, Equatable {
  public let alias: String
  public let links: Links
  
  enum CodingKeys: String, CodingKey {
    case alias
    case links = "_links"
  }
  
  public struct Links: Codable, Equatable {
    public let `self`: String
    public let short: String
    
    public init(self original: String, short: String) {
      self.`self` = original
      self.short = short
    }
  }
}
