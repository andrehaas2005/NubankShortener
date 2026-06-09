

public protocol LinkRepositoryProtocol {
  func save(_ alias: AliasResponse)
  func all() -> [AliasResponse]
  func all(page: Int, pageSize: Int) -> [AliasResponse]
  func clear()
}
