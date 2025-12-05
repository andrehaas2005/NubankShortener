import Foundation
import Core

final class InMemoryLinkRepository: LinkRepository {
    
  private var storage: [AliasResponse] = []
  
  func save(_ alias: AliasResponse) {
    storage.insert(alias, at: 0)
  }
  
  
  func all() -> [AliasResponse] {
    storage
  }
}
