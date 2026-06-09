import Foundation

/// Modelo destinado EXCLUSIVAMENTE à camada de UI.
/// Mantém o app desacoplado do modelo de rede.
public struct ShortenerUIModel: Identifiable, Equatable {
  public let id: UUID
  public  let alias: String
  public let short: String
  public let original: String
  
  // Valores pré-formatados para exibição
  public let displayTitle: String
  public let displaySubtitle: String
  
  public init(id: UUID, alias: String, short: String, original: String, displayTitle: String, displaySubtitle: String) {
    self.id = id
    self.alias = alias
    self.short = short
    self.original = original
    self.displayTitle = displayTitle
    self.displaySubtitle = displaySubtitle
  }
}
