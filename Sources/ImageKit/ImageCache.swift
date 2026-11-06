import Foundation

#if canImport(UIKit)
import SwiftUI
import UIKit
typealias ImageKitPlatformImage = UIImage

func ImageKitPlatformImageView(image: ImageKitPlatformImage) -> Image {
    Image(uiImage: image)
}
#elseif canImport(AppKit)
import AppKit
import SwiftUI
typealias ImageKitPlatformImage = NSImage

func ImageKitPlatformImageView(image: ImageKitPlatformImage) -> Image {
    Image(nsImage: image)
}
#endif

/// Stores downloaded platform images in memory and retrieves missing images
/// with `URLSession`.
actor ImageCache {
    static let shared = ImageCache()

    private let cache = NSCache<NSURL, ImageKitPlatformImage>()

    func image(for url: URL) async throws -> ImageKitPlatformImage {
        if let image = cache.object(forKey: url as NSURL) {
            return image
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let image = ImageKitPlatformImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }

        cache.setObject(image, forKey: url as NSURL)
        return image
    }
}
