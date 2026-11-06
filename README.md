# ImageKit

Small async image loader for iOS built with SwiftUI and `URLSession`.

## Requirements

- iOS 17+
- macOS 14+
- Swift 5.9+

## Installation

### Swift Package Manager

```swift
dependencies: [
.package(url: "https://github.com/RonaldoSwift/image-kit-ios.git", from: "1.0.0")
]
```

Add the `ImageKit` product to the target that uses it.

## Branch model & publishing

Versioning is automated with semantic-release and Conventional Commits:

- `develop` runs build and test without publishing.
- `main` runs tests and publishes a release when commits require one.
- `feat:` creates a minor release.
- `fix:`, `perf:`, and `refactor:` create a patch release.
- `BREAKING CHANGE:` creates a major release.

Tags and releases are created automatically. Do not create them manually.

### Tuist

```swift
// Tuist/Package.swift
let package = Package(
    name: "MyAppDependencies",
    dependencies: [
        .package(url: "https://github.com/RonaldoSwift/image-kit-ios.git", from: "1.0.0")
    ]
)
```

```swift
// Project.swift
dependencies: [
    .external(name: "ImageKit")
]
```

## Usage

```swift
import ImageKit

CachedAsyncImage(url: "https://example.com/image.png")
```

`CachedAsyncImage` keeps downloaded images in an in-memory cache for the lifetime of
the process.

## Local development

Build and test the package locally:

```bash
swift build
swift test
```
