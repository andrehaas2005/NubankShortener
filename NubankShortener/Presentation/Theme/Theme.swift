import UIKit

enum Theme {
    // Core colors (Nubank-like)
    static var primary: UIColor { UIColor(named: "Primary") ?? UIColor(red: 110/255, green: 0/255, blue: 255/255, alpha: 1) }
    static var primaryVariant: UIColor { UIColor(named: "PrimaryVariant") ?? UIColor(red: 90/255, green: 0/255, blue: 220/255, alpha: 1) }
    static var background: UIColor { UIColor.systemBackground }
    static var surface: UIColor { UIColor(named: "Surface") ?? UIColor(white: 0.98, alpha: 1) }
    static var text: UIColor { UIColor.label }
    static var muted: UIColor { UIColor.secondaryLabel }
    static var accent: UIColor { primary }

    // Tokens
    struct Radius {
        static let card: CGFloat = 16
        static let small: CGFloat = 8
    }

    struct Spacing {
        static let xs: CGFloat = 8
        static let sm: CGFloat = 16
        static let md: CGFloat = 24
        static let lg: CGFloat = 32
    }

    struct Typography {
        static var title: UIFont { UIFont.systemFont(ofSize: 24, weight: .semibold) }
        static var subtitle: UIFont { UIFont.systemFont(ofSize: 16, weight: .regular) }
        static var body: UIFont { UIFont.systemFont(ofSize: 15, weight: .regular) }
        static var caption: UIFont { UIFont.systemFont(ofSize: 13, weight: .regular) }
    }

    // Standard gradient used as background or button
    static func primaryGradientLayer(bounds: CGRect) -> CAGradientLayer {
        let g = CAGradientLayer()
        g.colors = [primaryVariant.cgColor, primary.cgColor]
        g.startPoint = CGPoint(x: 0, y: 0)
        g.endPoint = CGPoint(x: 1, y: 1)
        g.frame = bounds
        return g
    }
}
