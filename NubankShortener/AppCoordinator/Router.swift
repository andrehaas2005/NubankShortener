//
//  Router.swift
//  NubankShortener
//
//  Created by Andre  Haas on 05/12/25.
//


import UIKit

/// Abstração da navegação.
/// Permite que o Coordinator utilize navegação sem conhecer UINavigationController.
/// Facilita testes unitários e mocks.
protocol Router: AnyObject {
  
  /// Controle de navegação interno.
  var navigationController: UINavigationController { get }
  
  /// Faz um push padrão.
  func push(_ viewController: UIViewController, animated: Bool)
  
  /// Apresenta uma modal.
  func present(_ viewController: UIViewController, animated: Bool)
  
  /// Fecha o último push.
  func pop(animated: Bool)
  
  /// Define o root do fluxo atual.
  func setRoot(_ viewController: UIViewController, animated: Bool)
  
  /// Exibe um toast na view
  func showToast(viewController: UIViewController, _ message: String)
}
