import Foundation

/// O ViewModel notifica o ViewController.
/// Isso remove os @Published e Combine caso queira uma arquitetura 100% delegate-based.
/// Também funciona junto com Combine caso deseje usar ambos.
protocol ShortenerViewModelDelegate: AnyObject {
    func viewModelDidUpdateLinks()
    func viewModelDidShowError(_ message: String)
    func viewModelLoadingStateChanged(isLoading: Bool)
}
