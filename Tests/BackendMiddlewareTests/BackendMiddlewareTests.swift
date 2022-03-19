import XCTest
@testable import BackendMiddleware

final class BackendMiddlewareTests: XCTestCase {
	@available(macOS 12.0.0, *)
	func testGettingSnippets() async throws {
		let loginUser = BMLoginUser(email: "wiktorwojcik112@gmail.com", password: "testoweHaslo")
		let backendMiddleware = try await BackendMiddleware.getByLoggingIn(user: loginUser)
		let snippets = try await backendMiddleware.getSnippets()
		
		print(snippets)
	}
}
