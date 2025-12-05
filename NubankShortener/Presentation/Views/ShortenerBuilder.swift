//
//  ShortenerBuilder.swift
//  NubankShortener
//
//  Created by Andre  Haas on 04/12/25.
//


import UIKit

final class ShortenerBuilder: ModuleBuilder {

    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
    }

    func build() -> ShortenerViewController {
        let viewModel = ShortenerViewModel(
            service: container.makeLinkService(),
            repository: container.makeRepository()
        )

        return ShortenerViewController(viewModel: viewModel)
    }
}
