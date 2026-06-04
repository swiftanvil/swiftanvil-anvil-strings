import Foundation

/// A namespace that groups related `AppString` constants.
///
/// Conform to this protocol to create organized string catalogs:
///
/// ```swift
/// enum SettingsStrings: AppStringCatalog {
///     static let title = AppString("settings.title")
///     static let doneButton = AppString("settings.done")
/// }
/// ```
public protocol AppStringCatalog {
    /// The table name for localized strings in this catalog (default: nil = Localizable.strings).
    static var tableName: String? { get }
}

public extension AppStringCatalog {
    static var tableName: String? { nil }
}
