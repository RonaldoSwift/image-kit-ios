import SwiftUI

/// A SwiftUI view that loads a remote image and displays a progress indicator
/// until the image is available.
///
/// The view owns an `ImageLoader` with `@StateObject`. When it appears, the
/// loader checks `ImageCache` and downloads the image only when it is not cached.
public struct CachedAsyncImage: View {
    private let url: String
    @StateObject private var loader = ImageLoader()

    public init(url: String) {
        self.url = url
    }

    public var body: some View {
        Group {
            if let image = loader.image {
                ImageKitPlatformImageView(image: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            loader.load(from: url)
        }
    }
}
