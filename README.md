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

### How `CachedAsyncImage` works

The view in `Sources/ImageKit/CachedAsyncImage.swift` is a reusable SwiftUI
component for loading a remote image:

1. `url` stores the image address received by the initializer.
2. `@StateObject` creates and retains one `ImageLoader` for the view's lifetime.
3. While `loader.image` is `nil`, the view displays `ProgressView`.
4. Once the image is available, `ImageKitPlatformImageView` converts the
   platform image (`UIImage` on iOS or `NSImage` on macOS) into a SwiftUI
   `Image`, then applies `resizable()` and `scaledToFill()`.
5. `onAppear` starts the asynchronous load. The loader asks `ImageCache` for
   the URL, reusing an in-memory image when available or downloading and
   caching it when necessary.

This keeps networking and caching outside the view, so `CachedAsyncImage` only
describes the loading, success, and layout states.

## Local development

Build and test the package locally:

```bash
swift build
swift test
```
