import XCTest
@testable import ImageKit

final class ImageKitTests: XCTestCase {
    func testPackageExposesImageKitModule() {
        XCTAssertTrue(CachedAsyncImage.self == CachedAsyncImage.self)
    }
}
