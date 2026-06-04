import Foundation

/// A type-safe wrapper around localized string keys.
///
/// `AppString` separates the key (identifier) from the value (translated text)
/// so that typos in string keys become compile-time errors instead of runtime
/// missing-localization bugs.
///
/// ```swift
/// let title = AppString("welcome.title")
/// Text(title) // Looks up "welcome.title" in Localizable.strings
/// ```
public struct AppString: RawRepresentable, ExpressibleByStringLiteral, Hashable, Sendable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(stringLiteral value: String) {
        self.rawValue = value
    }

    /// Returns the localized string for this key using the main bundle.
    public var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }

    /// Returns the localized string with format arguments.
    public func localized(_ arguments: CVarArg...) -> String {
        String(format: localized, arguments: arguments)
    }
}

extension AppString: CustomStringConvertible {
    public var description: String { localized }
}
