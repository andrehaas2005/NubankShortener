import UIKit

final class PrimaryButton: UIButton {

    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = bounds
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = Theme.Radius.card
        clipsToBounds = true
        titleLabel?.font = Theme.Typography.subtitle
        setTitleColor(.white, for: .normal)
        configureGradient()
        heightAnchor.constraint(equalToConstant: 52).isActive = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 6)
        layer.shadowRadius = 12
        accessibilityTraits = .button
    }

    private func configureGradient() {
        gradientLayer?.removeFromSuperlayer()
        let g = Theme.primaryGradientLayer(bounds: bounds)
        gradientLayer = g
        layer.insertSublayer(g, at: 0)
    }

    public func setEnabled(_ enabled: Bool) {
        isEnabled = enabled
        alpha = enabled ? 1 : 0.6
    }
}
