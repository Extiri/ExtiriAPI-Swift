//
//  AsyncVersions.swift
//  
//
//  Created by Wiktor Wójcik on 22/02/2022.
//

import Foundation

@available(macOS 12.0, *)
extension BackendMiddleware {
	func getSnippets(after: String? = nil) async throws -> [BMSnippet] {
		return try await withCheckedThrowingContinuation { continuation in
			getSnippets(after: after) { result in
				switch result {
					case .success(let snippets):
						continuation.resume(returning: snippets)
					case .failure(let error):
						continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func getSnippet(id: String) async throws -> BMSnippet {
		return try await withCheckedThrowingContinuation { continuation in
			getSnippet(id: id) { result in
				switch result {
					case .success(let snippet):
						continuation.resume(returning: snippet)
					case .failure(let error):
						continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func createSnippet(snippet: BMNewSnippet) async throws -> BMSnippet {
		return try await withCheckedThrowingContinuation { continuation in
			createSnippet(snippet: snippet) { result in
				switch result {
					case .success(let snippet):
						continuation.resume(returning: snippet)
					case .failure(let error):
						continuation.resume(throwing: error)
				}
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
				switch result {
					case .success(let user):
						continuation.resume(returning: user)
					case .failure(let error):
						continuation.resume(throwing: error)
				}
			}
		}
	}
	
	func loginUser(user: BMLoginUser) async throws -> BMToken {
		return try await withCheckedThrowingContinuation { continuation in
			loginUser(user: user) { result in
				switch result {
					case .success(let token):
						continuation.resume(returning: token)
					case .failure(let error):
						continuation.resume(throwing: error)
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
}
