import Foundation
import Testing
@testable import AppStrings

@Suite("AppString")
struct AppStringTests {
    @Test("initializes from string literal")
    func stringLiteral() {
        let str: AppString = "welcome.title"
        #expect(str.rawValue == "welcome.title")
    }

    @Test("initializes from raw value")
    func rawValue() {
        let str = AppString(rawValue: "settings.done")
        #expect(str.rawValue == "settings.done")
    }

    @Test("conforms to Hashable")
    func hashable() {
        let a = AppString(rawValue: "a")
        let b = AppString(rawValue: "a")
        let c = AppString(rawValue: "b")
        #expect(a == b)
        #expect(a != c)
    }

    @Test("conforms to Sendable")
    func sendable() {
        let str = AppString(rawValue: "test")
        let boxed: Sendable = str
        #expect((boxed as? AppString)?.rawValue == "test")
    }

    @Test("custom description returns raw value")
    func description() {
        let str = AppString(rawValue: "key")
        #expect(str.description == "key")
    }
}

@Suite("AppStringBuilder")
struct AppStringBuilderTests {
    @Test("builds concatenated string")
    func buildConcatenation() {
        let result = AppString.build {
            AppString(rawValue: "hello")
            AppString(rawValue: " ")
            AppString(rawValue: "world")
        }
        #expect(result.rawValue == "hello world")
    }

    @Test("builds optional when present")
    func buildOptionalPresent() {
        let suffix: AppString? = AppString(rawValue: "!")
        let result = AppString.build {
            AppString(rawValue: "hi")
            suffix
        }
        #expect(result.rawValue == "hi!")
    }

    @Test("builds optional when nil")
    func buildOptionalNil() {
        let suffix: AppString? = nil
        let result = AppString.build {
            AppString(rawValue: "hi")
            suffix
        }
        #expect(result.rawValue == "hi")
    }
}

@Suite("AppStringCatalog")
struct AppStringCatalogTests {
    @Test("catalog has default table name")
    func defaultTableName() {
        enum TestCatalog: AppStringCatalog {}
        #expect(TestCatalog.tableName == nil)
    }
}
