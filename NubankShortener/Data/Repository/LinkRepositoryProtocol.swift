

public protocol LinkRepositoryProtocol {
  func save(_ alias: AliasResponse)
  func all() -> [AliasResponse]
  func clear()
}
