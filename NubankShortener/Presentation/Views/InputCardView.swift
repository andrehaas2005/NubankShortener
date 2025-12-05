//
//  InputCardView.swift
//  NubankShortener
//
//  Created by Andre  Haas on 04/12/25.
//


import UIKit

final class InputCardView: UIView {

    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "https://exemplo.com"
        tf.clearButtonMode = .whileEditing
        tf.font = Theme.Typography.body
        tf.accessibilityLabel = "Campo para colar ou digitar a URL"
        tf.autocapitalizationType = .none
        tf.keyboardType = .URL
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let actionButton: PrimaryButton = {
        let btn = PrimaryButton(type: .system)
        btn.setTitle("Encurtar", for: .normal)
        btn.accessibilityLabel = "Encurtar link"
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()

    private let card = CardView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        card.translatesAutoresizingMaskIntoConstraints = false
        addSubview(card)

        card.addSubview(textField)
        card.addSubview(actionButton)

        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor),
            card.leadingAnchor.constraint(equalTo: leadingAnchor),
            card.trailingAnchor.constraint(equalTo: trailingAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor),

            textField.topAnchor.constraint(equalTo: card.topAnchor, constant: Theme.Spacing.sm),
            textField.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: Theme.Spacing.sm),
            textField.trailingAnchor.constraint(equalTo: actionButton.leadingAnchor, constant: -Theme.Spacing.sm),
            textField.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -Theme.Spacing.sm),

            actionButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            actionButton.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -Theme.Spacing.sm),
            actionButton.widthAnchor.constraint(equalToConstant: 96),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
