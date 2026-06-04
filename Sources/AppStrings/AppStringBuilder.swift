import Foundation

/// A result-builder for constructing compound localized strings.
///
/// ```swift
/// let message = AppString.build {
///     AppString("greeting.prefix")
///     " "
///     AppString("greeting.name")
/// }
/// ```
@resultBuilder
public enum AppStringBuilder {
    public static func buildBlock(_ components: AppString...) -> AppString {
        AppString(rawValue: components.map(\.rawValue).joined())
    }

    public static func buildExpression(_ expression: AppString) -> AppString {
        expression
    }

    public static func buildExpression(_ expression: AppString?) -> AppString {
        expression ?? AppString(rawValue: "")
    }

    public static func buildOptional(_ component: AppString?) -> AppString {
        component ?? AppString(rawValue: "")
    }

    public static func buildEither(first component: AppString) -> AppString {
        component
    }

    public static func buildEither(second component: AppString) -> AppString {
        component
    }
}

public extension AppString {
    /// Constructs an AppString using the result builder.
    static func build(@AppStringBuilder _ content: () -> AppString) -> AppString {
        content()
    }
}
