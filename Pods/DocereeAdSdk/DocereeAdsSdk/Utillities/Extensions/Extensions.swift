
import UIKit


extension DocereeAdRequestError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .failedToCreateRequest: return NSLocalizedString("Failed to load ad. Please contact support@doceree.com", comment: "")
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension NSData {
    var imageFormat: ImageFormat {
        var buffer = [UInt8](repeating: 0, count: 1)
        self.getBytes(&buffer, range: NSRange(location: 0, length: 1))
        if buffer == ImageHeaderData.GIF {
            return .GIF
        } else if buffer == ImageHeaderData.JPEG {
            return .JPEG
        } else if buffer == ImageHeaderData.PNG{
            return .PNG
        } else if buffer == ImageHeaderData.TIFF_01 || buffer == ImageHeaderData.TIFF_02 {
            return .TIFF
        } else {
            return .Unknown
        }
    }
}

extension NotificationCenter {
    func setObserver(observer: Any, selector: Selector, name: NSNotification.Name, object: AnyObject?){
        NotificationCenter.default.removeObserver(observer, name: name, object: object)
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
}

extension DateFormatter {

    static let iso8601DateFormatter: DateFormatter = {
        let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
        let iso8601DateFormatter = DateFormatter()
        iso8601DateFormatter.locale = enUSPOSIXLocale
        iso8601DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        iso8601DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return iso8601DateFormatter
    }()

    static let iso8601WithoutMillisecondsDateFormatter: DateFormatter = {
        let enUSPOSIXLocale = Locale(identifier: "en_US_POSIX")
        let iso8601DateFormatter = DateFormatter()
        iso8601DateFormatter.locale = enUSPOSIXLocale
        iso8601DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        iso8601DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return iso8601DateFormatter
    }()

    static func date(fromISO8601String string: String) -> Date? {
        if let dateWithMilliseconds = iso8601DateFormatter.date(from: string) {
            return dateWithMilliseconds
        }

        if let dateWithoutMilliseconds = iso8601WithoutMillisecondsDateFormatter.date(from: string) {
            return dateWithoutMilliseconds
        }

        return nil
    }
}
