import Foundation

public class BackendMiddleware {
	var jsonDecoder: JSONDecoder {
		get {
			let jsonDecoder = JSONDecoder()
			
			jsonDecoder.dateDecodingStrategy = .iso8601
			
			return jsonDecoder
		}
	}
	
	private var token: String
	
	public enum Environment {
		case Development
		case Production
	}
	
	private var enironment: Environment
	private var host: String {
		switch enironment {
			case .Development:
				return "http://127.0.0.1:8080/"
			case .Production:
				return "https://extiri.com/"
		}
	}
	
	public init(token: String, environment: Environment = .Production) {
		self.token = token
		self.enironment = environment
	}
	
	var jsonEncoder: JSONEncoder = JSONEncoder()
	
	public func getSnippets(after: String? = nil, completionHandler: @escaping (Result<[BMSnippet], Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/snippets\(after != nil ? "/?after=\(after!)" : "")")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
					}
				}
				
				do {
					let snippets = try self.jsonDecoder.decode([BMSnippet].self, from: data!)
					
					completionHandler(.success(snippets))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func getSnippet(id: String, completionHandler: @escaping (Result<BMSnippet, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/snippets/get/\(id)")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
					}
				}
				
				do {
					let snippet = try self.jsonDecoder.decode(BMSnippet.self, from: data!)
					
					completionHandler(.success(snippet))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func deleteSnippet(id: String, completionHandler: @escaping (Error?) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/snippets/delete/\(token)/\(id)")!)
		
		request.httpMethod = "DELETE"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(error)
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(self.getError(statusCode: httpResponse.statusCode, data: data!))
					}
				}
				
				completionHandler(nil)
			}
		}
		
		dataTask.resume()
	}
	
	public func createSnippet(snippet: BMNewSnippet, completionHandler: @escaping (Result<BMSnippet, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/snippets/create/\(token)")!)
		
		request.httpMethod = "POST"
	
		do {
			let data = try jsonEncoder.encode(snippet)
			
			request.httpBody = data
			request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		} catch {
			completionHandler(.failure(error))
		}
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
					}
				}
				
				do {
					let snippet = try self.jsonDecoder.decode(BMSnippet.self, from: data!)
					
					completionHandler(.success(snippet))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func isTokenValid(completionHandler: @escaping (Result<BMUser, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/users/valid/\(token)")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
					}
				}
				
				do {
					let snippet = try self.jsonDecoder.decode(BMUser.self, from: data!)
					
					completionHandler(.success(snippet))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func getUser(id: String, completionHandler: @escaping (Result<BMUser, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/users/get/\(id)")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
					}
				}
				
				do {
					let snippet = try self.jsonDecoder.decode(BMUser.self, from: data!)
					
					completionHandler(.success(snippet))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func loginUser(user: BMLoginUser, completionHandler: @escaping (Result<BMToken, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/snippets/login")!)
		
		request.httpMethod = "POST"
		
		do {
			let data = try jsonEncoder.encode(user)
			
			request.httpBody = data
			request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		} catch {
			completionHandler(.failure(error))
		}
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
					}
				}
				
				do {
					let snippet = try self.jsonDecoder.decode(BMToken.self, from: data!)
					
					completionHandler(.success(snippet))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func signupUser(user: BMNewUser, completionHandler: @escaping (Error?) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/snippets/delete")!)
		
		request.httpMethod = "POST"
		
		do {
			let data = try jsonEncoder.encode(user)
			
			request.httpBody = data
			request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		} catch {
			completionHandler(error)
		}
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(error)
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(self.getError(statusCode: httpResponse.statusCode, data: data!))
					}
				}

				completionHandler(nil)
			}
		}
		
		dataTask.resume()
	}
	
	public func deleteUser(user: BMLoginUser, completionHandler: @escaping (Error?) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/snippets/login")!)
		
		request.httpMethod = "POST"
		
		do {
			let data = try jsonEncoder.encode(user)
			
			request.httpBody = data
			request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		} catch {
			completionHandler(error)
		}
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(error)
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(self.getError(statusCode: httpResponse.statusCode, data: data!))
					}
				}
				
				completionHandler(nil)
			}
		}
		
		dataTask.resume()
	}
	
	private func getError(statusCode: Int, data: Data) -> Error {
		if statusCode == 303 {
			return NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Endpoint or provided element doesn't exist."])
		} else {
			return NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: String(data: data, encoding: .utf8)!])
		}
	}
}
