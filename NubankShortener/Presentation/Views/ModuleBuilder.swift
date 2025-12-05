//
//  ModuleBuilder.swift
//  NubankShortener
//
//  Created by Andre  Haas on 04/12/25.
//

import UIKit


protocol ModuleBuilder {
    associatedtype ViewControllerType: UIViewController
    func build() -> ViewControllerType
}
