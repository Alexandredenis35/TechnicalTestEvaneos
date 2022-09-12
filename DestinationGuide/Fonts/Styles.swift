import UIKit

extension UIFont {
    public class func avertaExtraBold(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Averta-ExtraBold", size: fontSize) ?? UIFont
            .systemFont(ofSize: fontSize, weight: .heavy)
    }

    public class func avertaSemibold(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Averta-Semibold", size: fontSize) ?? UIFont
            .systemFont(ofSize: fontSize, weight: .semibold)
    }

    public class func avertaLight(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Averta-Light", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .light)
    }

    public class func avertaRegular(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Averta-Regular", size: fontSize) ?? UIFont
            .systemFont(ofSize: fontSize, weight: .regular)
    }

    public class func avertaBold(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "Averta-Bold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
}

extension UIColor {
    public static let defaultSemiTransparencyAlpha: CGFloat = 0.5
    public static let defaultAppBackgroundColor = UIColor.evaneos(color: .paperLight)

    public enum EvaneosColor {
        case veraneos
        case veraneosDark
        case green
        case greenDark
        case greenLightest
        case turquoise
        case blue
        case orangeLight
        case orangeDark
        case redLight
        case red
        case gold
        case purpleLight
        case purpleDark
        case pink
        case tan
        case paperLight
        case inkLighter
        case paper
        case inkLight
        case paperDark
        case paperDarker
        case ink
        case blueLightest

        public func rgb() -> (CGFloat, CGFloat, CGFloat) {
            switch self {
            case .veraneos: return (0.08, 0.44, 0.42)
            case .veraneosDark: return (0.00, 0.36, 0.337)
            case .green: return (0.07, 0.72, 0.53)
            case .greenDark: return (0.01, 0.55, 0.38)
            case .greenLightest: return (0.84, 0.97, 0.93)
            case .turquoise: return (0.00, 0.85, 0.73)
            case .blue: return (0.07, 0.61, 0.67)
            case .orangeLight: return (0.97, 0.60, 0.34)
            case .orangeDark: return (0.93, 0.39, 0.11)
            case .red: return (0.86, 0.17, 0.14)
            case .redLight: return (0.92, 0.44, 0.42)
            case .gold: return (1.00, 0.70, 0.00)
            case .purpleLight: return (0.80, 0.60, 0.64)
            case .purpleDark: return (0.48, 0.00, 0.32)
            case .pink: return (0.98, 0.67, 0.58)
            case .tan: return (0.71, 0.64, 0.40)
            case .paperLight: return (0.99, 0.99, 0.98)
            case .inkLighter: return (0.68, 0.71, 0.74)
            case .paper: return (0.98, 0.98, 0.97)
            case .inkLight: return (0.53, 0.56, 0.59)
            case .paperDark: return (0.96, 0.95, 0.95)
            case .paperDarker: return (0.9333, 0.9137, 0.8980)
            case .ink: return (0.20, 0.23, 0.25)
            case .blueLightest: return (0.86, 0.96, 0.98)
            }
        }
    }

    public class func evaneos(color: EvaneosColor, alpha: CGFloat = 1) -> UIColor {
        let (r, g, b) = color.rgb()
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }

    public class func evaneosSemiTransparent(color: EvaneosColor) -> UIColor {
        return evaneos(color: color, alpha: UIColor.defaultSemiTransparencyAlpha)
    }
}
