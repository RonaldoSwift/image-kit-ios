import Combine
import Foundation
import UIKit

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?

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
