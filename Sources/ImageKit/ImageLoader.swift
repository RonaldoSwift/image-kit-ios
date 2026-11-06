import Combine
import Foundation

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/// Manages the observable loading state used by `CachedAsyncImage`.
///
/// The loader publishes the platform image and starts the asynchronous cache
/// lookup or download when `load(from:)` is called.
@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: ImageKitPlatformImage?

    func load(from urlString: String) {
        guard image == nil, let url = URL(string: urlString) else {
            return
        }

        Task {
            do {
                image = try await ImageCache.shared.image(for: url)
            } catch {
                print(error)
            }
        }
    }
}
