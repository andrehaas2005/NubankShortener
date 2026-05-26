import Foundation

/// Modelo destinado EXCLUSIVAMENTE à camada de UI.
/// Mantém o app desacoplado do modelo de rede.
struct ShortenerUIModel: Identifiable, Equatable {
    let id: UUID
    let alias: String
    let short: String
    let original: String

    // Valores pré-formatados para exibição
    let displayTitle: String
    let displaySubtitle: String
}
