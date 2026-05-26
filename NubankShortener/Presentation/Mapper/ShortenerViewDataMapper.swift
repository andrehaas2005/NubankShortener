import Foundation
import Core

/// DATA MAPPER:
/// Conversões, mapeamentos e formatações.
/// Ele pega os modelos do domínio/engine e transforma em algo
/// mais adequado para exibição, persistência ou fluxo interno.
///
/// Mantém o ViewModel extremamente limpo.
final class ShortenerViewDataMapper: ShortenerViewDataMapperDelegate {
    func toUIModel(_ domain: AliasResponse) -> ShortenerUIModel {
        return ShortenerUIModel(
            id: UUID(),
            alias: domain.alias,
            short: domain.links.short,
            original: domain.links.`self`,
            displayTitle: "🔗 \(domain.alias)",
            displaySubtitle: domain.links.short
        )
    }

    /// Converte lista de respostas da API → UI models
    func toUIModels(_ list: [AliasResponse]) -> [ShortenerUIModel] {
        list.map { toUIModel($0) }
    }
}
