//
//  AsyncVersions.swift
//  
//
//  Created by Wiktor Wójcik on 22/02/2022.
//

import Foundation
import AppKit

@available(macOS 12.0, *)
extension BackendMiddleware {
	func getSnippets(after: String? = nil) async throws -> [BMSnippet] {
		return try await withCheckedThrowingContinuation { continuation in
			getSnippets(after: after) { result in
				continuation.resume(with: result)
			}
		}
	}
	
	func getSnippet(id: String) async throws -> BMSnippet {
		return try await withCheckedThrowingContinuation { continuation in
			getSnippet(id: id) { result in
				continuation.resume(with: result)
			}
		}
	}
	
	func createSnippet(snippet: BMNewSnippet) async throws -> BMSnippet {
		return try await withCheckedThrowingContinuation { continuation in
			createSnippet(snippet: snippet) { result in
				continuation.resume(with: result)
			}
		}
	}
	
	func deleteSnippet(id: String) async throws {
		return try await withCheckedThrowingContinuation { continuation in
			deleteSnippet(id: id) { error in
				if let error = error {
					continuation.resume(throwing: error)
				} else {
					continuation.resume()
				}
			}
		}
	}
	
	func getUser(id: String) async throws -> BMUser {
		return try await withCheckedThrowingContinuation { continuation in
			getUser(id: id) { result in
				continuation.resume(with: result)
			}
		}
	}
	
	func loginUser(user: BMLoginUser) async throws -> BMToken {
		return try await withCheckedThrowingContinuation { continuation in
			loginUser(user: user) { result in
				continuation.resume(with: result)
			}
		}
	}
	
	func logoutUser(user: BMLoginUser) async throws {
		return try await withCheckedThrowingContinuation { continuation in
			logoutUser(user: user) { error in
				if let error = error {
					continuation.resume(throwing: error)
				} else {
					continuation.resume()
				}
			}
		}
	}
	
	func signupUser(user: BMNewUser) async throws {
		return try await withCheckedThrowingContinuation { continuation in
			signupUser(user: user) { error in
				if let error = error {
					continuation.resume(throwing: error)
				} else {
					continuation.resume()
				}
			}
		}
	}
	
	func deleteUser(user: BMLoginUser) async throws {
		return try await withCheckedThrowingContinuation { continuation in
			deleteUser(user: user) { error in
				if let error = error {
					continuation.resume(throwing: error)
				} else {
					continuation.resume()
				}
			}
		}
	}
	
	static func getByLoggingIn(user: BMLoginUser) async throws -> BackendMiddleware {
		return try await withCheckedThrowingContinuation { continuation in
			getByLoggingIn(user: user) { result in
				continuation.resume(with: result)
			}
		}
	}
	
	static func login(user: BMLoginUser) async throws -> BMToken {
		return try await withCheckedThrowingContinuation { continuation in
			login(user: user) { result in
				continuation.resume(with: result)
			}
		}
	}
	
	static func signup(user: BMNewUser) async throws {
		return try await withCheckedThrowingContinuation { continuation in
			signup(user: user) { error in
				if let error = error {
					continuation.resume(throwing: error)
				} else {
					continuation.resume()
				}
			}
		}
	}
}
