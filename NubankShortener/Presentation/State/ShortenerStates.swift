import Core

public enum ShortenerStates: Equatable {
  case idle
  case success([AliasResponse])
  case loading(Bool)
  case error(String)
}
