import Combine
import Foundation

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

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
