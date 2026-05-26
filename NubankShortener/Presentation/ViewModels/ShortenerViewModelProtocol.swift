import Core

public protocol ShortenerViewModelProtocol: AnyObject {
  var screenState: Bindable<ShortenerStates?> { get }
}

