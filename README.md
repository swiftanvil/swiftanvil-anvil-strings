# AppStrings

Type-safe localized string keys for Swift.

## Description

`AppStrings` separates the string key (identifier) from the translated value so that typos in localization keys become compile-time errors instead of runtime missing-localisation bugs. It includes a result builder for composing compound strings and a catalog protocol for grouping related constants.

## Installation

Add the package dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/swiftanvil/swiftanvil-anvil-strings.git", from: "1.0.0"),
]
```

Then add `AppStrings` to your target:

```swift
.target(name: "MyTarget", dependencies: [
    .product(name: "AppStrings", package: "swiftanvil-anvil-strings"),
])
```

## Usage

```swift
import AppStrings

// Simple localized string
let title = AppString("welcome.title")
Text(title.localized)

// Formatted string
let count = 5
let message = AppString("items.count").localized(count)

// Result builder
let greeting = AppString.build {
    AppString("greeting.prefix")
    " "
    AppString("greeting.name")
}

// Catalog
enum SettingsStrings: AppStringCatalog {
    static let title = AppString("settings.title")
    static let doneButton = AppString("settings.done")
}
```

## Build & Test

```bash
swift build
swift test
```
