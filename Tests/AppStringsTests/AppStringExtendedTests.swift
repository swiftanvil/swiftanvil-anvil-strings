import Foundation
import Testing
@testable import AppStrings

// MARK: - Localization

@Suite("AppString Localization")
struct AppStringLocalizationTests {
    @Test("localized returns a string")
    func localizedReturnsString() {
        let str = AppString(rawValue: "test.key")
        let result = str.localized
        #expect(!result.isEmpty)
    }

    @Test("localized with arguments returns formatted string")
    func localizedWithArguments() {
        let str = AppString(rawValue: "test.format")
        let result = str.localized("hello", 42)
        // Since key may not exist, it returns the key or a formatted version
        #expect(!result.isEmpty)
    }

    @Test("description matches localized")
    func descriptionMatchesLocalized() {
        let str = AppString(rawValue: "description.test")
        #expect(str.description == str.localized)
    }

    @Test("empty key returns empty localized")
    func emptyKey() {
        let str = AppString(rawValue: "")
        #expect(str.localized == "")
    }
}

// MARK: - Interpolation & Formatting

@Suite("AppString Interpolation")
struct AppStringInterpolationTests {
    @Test("multiple format arguments")
    func multipleArguments() {
        let str = AppString(rawValue: "test.multi")
        let result = str.localized("a", "b", "c")
        #expect(!result.isEmpty)
    }

    @Test("numeric format arguments")
    func numericArguments() {
        let str = AppString(rawValue: "test.numbers")
        let result = str.localized(1, 2.5, 42)
        #expect(!result.isEmpty)
    }
}

// MARK: - Builder Pattern Extended

@Suite("AppStringBuilder Extended")
struct AppStringBuilderExtendedTests {
    @Test("builds with single component")
    func singleComponent() {
        let result = AppString.build {
            AppString(rawValue: "only")
        }
        #expect(result.rawValue == "only")
    }

    @Test("builds with empty optional")
    func emptyOptional() {
        let maybe: AppString? = nil
        let result = AppString.build {
            AppString(rawValue: "start")
            maybe
            AppString(rawValue: "end")
        }
        #expect(result.rawValue == "startend")
    }

    @Test("builds with conditional true")
    func conditionalTrue() {
        let flag = true
        let result = AppString.build {
            AppString(rawValue: "prefix")
            if flag {
                AppString(rawValue: "-flagged")
            }
        }
        #expect(result.rawValue == "prefix-flagged")
    }

    @Test("builds with conditional false")
    func conditionalFalse() {
        let flag = false
        let result = AppString.build {
            AppString(rawValue: "prefix")
            if flag {
                AppString(rawValue: "-flagged")
            }
        }
        #expect(result.rawValue == "prefix")
    }

    @Test("builds with if-else true branch")
    func ifElseTrue() {
        let flag = true
        let result = AppString.build {
            if flag {
                AppString(rawValue: "yes")
            } else {
                AppString(rawValue: "no")
            }
        }
        #expect(result.rawValue == "yes")
    }

    @Test("builds with if-else false branch")
    func ifElseFalse() {
        let flag = false
        let result = AppString.build {
            if flag {
                AppString(rawValue: "yes")
            } else {
                AppString(rawValue: "no")
            }
        }
        #expect(result.rawValue == "no")
    }

    @Test("builds complex nested structure")
    func complexNested() {
        let includeSuffix = true
        let suffix: AppString? = AppString(rawValue: "!")
        let result = AppString.build {
            AppString(rawValue: "Hello")
            if includeSuffix {
                AppString(rawValue: " World")
            }
            suffix
        }
        #expect(result.rawValue == "Hello World!")
    }
}

// MARK: - Catalog Extended

@Suite("AppStringCatalog Extended")
struct AppStringCatalogExtendedTests {
    @Test("catalog with custom table name")
    func customTableName() {
        enum CustomCatalog: AppStringCatalog {
            static var tableName: String? { "CustomStrings" }
        }
        #expect(CustomCatalog.tableName == "CustomStrings")
    }

    @Test("multiple catalogs have independent table names")
    func independentTableNames() {
        enum CatalogA: AppStringCatalog {
            static var tableName: String? { "A" }
        }
        enum CatalogB: AppStringCatalog {
            static var tableName: String? { "B" }
        }
        #expect(CatalogA.tableName == "A")
        #expect(CatalogB.tableName == "B")
    }
}

// MARK: - Hashable & Sendable Extended

@Suite("AppString Conformance Extended")
struct AppStringConformanceTests {
    @Test("equal strings have same hash")
    func equalHash() {
        let a = AppString(rawValue: "key")
        let b = AppString(rawValue: "key")
        #expect(a.hashValue == b.hashValue)
    }

    @Test("different strings have different hash")
    func differentHash() {
        let a = AppString(rawValue: "a")
        let b = AppString(rawValue: "b")
        #expect(a.hashValue != b.hashValue)
    }

    @Test("can be used as Set element")
    func setElement() {
        let a = AppString(rawValue: "x")
        let b = AppString(rawValue: "y")
        let set: Set<AppString> = [a, b, a]
        #expect(set.count == 2)
    }

    @Test("crosses actor boundary as Sendable")
    func sendableAcrossActors() async {
        let str = AppString(rawValue: "sendable.test")
        let result = await checkAppStringSendable(str)
        #expect(result == "sendable.test")
    }
}

func checkAppStringSendable(_ str: AppString) async -> String {
    str.rawValue
}
