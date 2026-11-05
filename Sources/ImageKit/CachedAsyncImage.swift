import SwiftUI

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
