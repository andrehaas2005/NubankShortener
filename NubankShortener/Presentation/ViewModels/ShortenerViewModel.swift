import Foundation
import Core
internal import Combine


@MainActor
final class ShortenerViewModel {
  private let service: LinkServiceProtocol
  private let repository: LinkRepository
  
  @Published private(set) var isLoading = false
  @Published private(set) var links: [AliasResponse] = []
  @Published private(set) var errorMessage: String?
  
  init(service: LinkServiceProtocol, repository: LinkRepository) {
    self.service = service
    self.repository = repository
    self.links = repository.all()
  }
  
  func shorten(_ text: String) async {
    guard Validators.isValidURL(text) else {
      errorMessage = "URL inválida"
      return
    }
    
    isLoading = true
    defer { isLoading = false }
    
    do {
      let response = try await service.shorten(url: text)
      repository.save(response)
      links = repository.all()
    } catch {
      errorMessage = "Erro ao encurtar URL"
    }
  }
}
