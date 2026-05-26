import Foundation
import Core

/// Caso o Adapter tenha lógicas assíncronas ou customizáveis,
/// podemos receber retorno via delegate.
/// Em apps menores pode ser omitido.
protocol ShortenerViewDataMapperDelegate: AnyObject {
  func toUIModel(_ domain: AliasResponse) -> ShortenerUIModel
  func toUIModels(_ list: [AliasResponse]) -> [ShortenerUIModel]
}
