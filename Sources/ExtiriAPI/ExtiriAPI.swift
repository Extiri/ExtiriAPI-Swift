import Foundation

public class ExtiriAPI {
	var jsonDecoder: JSONDecoder {
		get {
			let jsonDecoder = JSONDecoder()
			
			jsonDecoder.dateDecodingStrategy = .iso8601
			
			return jsonDecoder
		}
	}
	
	public var token: String
	public var version = 1

  public var host = "https://extiri.com/"
	
	public init(token: String) {
		self.token = token
	}
	
	var jsonEncoder: JSONEncoder = JSONEncoder()
	
	public func isReachable(completionHandler: @escaping (Bool) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/snippets")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if error != nil {
				completionHandler(false)
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(false)
						return
					}
				}
				
				if self.parseAsError(data: data!) != nil {
					completionHandler(false)
					return
				}
				
				completionHandler(true)
			}
		}
		
		dataTask.resume()
	}
	
	
	public func getTotalNumberOfSnippets(query: String? = nil, language: String? = nil, category: String? = nil, creator: String? = nil, completionHandler: @escaping (Result<Count, Error>) -> ()) {
		var urlString = host + "api/\(version)/snippets/countOfTotalResults/?"
		
		let parameters = [
			"query": query,
			"language": language,
			"category": category,
			"creator": creator
		]
		
		for (key, value) in parameters {
			if let value = value {
				urlString.append("\(key)=\(value)&")
			}
		}
		
		var request = URLRequest(url: URL(string: urlString)!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let response = try self.jsonDecoder.decode(Count.self, from: data!)
					
					completionHandler(.success(response))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func getSnippets(page: Int = 1, query: String? = nil, language: String? = nil, category: String? = nil, creator: String? = nil, completionHandler: @escaping (Result<SnippetsResponse, Error>) -> ()) {
		var urlString = host + "api/\(version)/snippets/?"
		
		let parameters = [
			"page": String(page),
			"query": query,
			"language": language,
			"category": category,
			"creator": creator
		]
		
		for (key, value) in parameters {
			if let value = value {
				urlString.append("\(key)=\(value)&")
			}
		}
		
		var request = URLRequest(url: URL(string: urlString)!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let response = try self.jsonDecoder.decode(SnippetsResponse.self, from: data!)
					
					completionHandler(.success(response))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func getLanguages(completionHandler: @escaping (Result<[String], Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/languages")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let languages = try self.jsonDecoder.decode([String].self, from: data!)
					
					completionHandler(.success(languages))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func getCategories(completionHandler: @escaping (Result<[String], Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/categories")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let categories = try self.jsonDecoder.decode([String].self, from: data!)
					
					completionHandler(.success(categories))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func getSnippet(id: String, completionHandler: @escaping (Result<Snippet, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/snippets/get/\(id)")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let snippet = try self.jsonDecoder.decode(Snippet.self, from: data!)
					
					completionHandler(.success(snippet))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func deleteSnippet(id: String, completionHandler: @escaping (Error?) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/snippets/delete/\(id)")!)
		
		request.httpMethod = "DELETE"
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(error)
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(self.getError(statusCode: httpResponse.statusCode, data: data!))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(error)
					return
				}
				
				completionHandler(nil)
			}
		}
		
		dataTask.resume()
	}
	
	public func createSnippet(snippet: NewSnippet, completionHandler: @escaping (Result<Snippet, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/snippets/create")!)
		
		request.httpMethod = "POST"
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
	
		do {
			let data = try jsonEncoder.encode(snippet)
			
			request.httpBody = data
			request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		} catch {
			completionHandler(.failure(error))
			return
		}
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let snippet = try self.jsonDecoder.decode(Snippet.self, from: data!)
					
					completionHandler(.success(snippet))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func isTokenValid(completionHandler: @escaping (Result<Bool, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/users/valid")!)
		
		request.httpMethod = "GET"
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						if httpResponse.statusCode == 401 {
							completionHandler(.success(false))
							return
						} else {
							completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
							return
						}
					}
				} else {
					fatalError("Unable to parse HTTP status code. It's unexpectedly nil.")
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				completionHandler(.success(true))
			}
		}
		
		dataTask.resume()
	}
	
	public func getUser(id: String, completionHandler: @escaping (Result<User, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/users/get/\(id)")!)
		
		request.httpMethod = "GET"
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let user = try self.jsonDecoder.decode(User.self, from: data!)
					
					completionHandler(.success(user))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func getUserInfo(completionHandler: @escaping (Result<InfoUser, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/users/me")!)

		request.httpMethod = "GET"
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(.failure(error))
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let user = try self.jsonDecoder.decode(InfoUser.self, from: data!)
					
					completionHandler(.success(user))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func loginUser(user: LoginUser, completionHandler: @escaping (Result<Token, Error>) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/users/login")!)
		
		let credentialsString = "\(user.email):\(user.password)"
		let credentials = Data(credentialsString.utf8).base64EncodedString()
		
		request.httpMethod = "POST"
		request.addValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
		
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
				return
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(.failure(self.getError(statusCode: httpResponse.statusCode, data: data!)))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(.failure(error))
					return
				}
				
				do {
					let user = try self.jsonDecoder.decode(Token.self, from: data!)
					
					completionHandler(.success(user))
				} catch {
					completionHandler(.failure(error))
				}
			}
		}
		
		dataTask.resume()
	}
	
	public func logoutUser(completionHandler: @escaping (Error?) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/users/logout")!)
		
		request.httpMethod = "GET"
		request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(error)
				return
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(self.getError(statusCode: httpResponse.statusCode, data: data!))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(error)
					return
				}
				
				completionHandler(nil)
			}
		}
		
		dataTask.resume()
	}
	
	public func signupUser(user: NewUser, completionHandler: @escaping (Error?) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/users/signup")!)
		
		request.httpMethod = "POST"
		
		do {
			let data = try jsonEncoder.encode(user)
			
			request.httpBody = data
			request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		} catch {
			completionHandler(error)
			return
		}
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(error)
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(self.getError(statusCode: httpResponse.statusCode, data: data!))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(error)
					return
				}

				completionHandler(nil)
			}
		}
		
		dataTask.resume()
	}
	
	public func deleteUser(user: LoginUser, completionHandler: @escaping (Error?) -> ()) {
		var request = URLRequest(url: URL(string: host + "api/\(version)/users/delete")!)
		
		request.httpMethod = "DELETE"
		
		do {
			let data = try jsonEncoder.encode(user)
			
			request.httpBody = data
			request.setValue("\(data.count)", forHTTPHeaderField: "Content-Length")
			request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		} catch {
			completionHandler(error)
			return
		}
		
		let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
			if let error = error {
				completionHandler(error)
			} else {
				if let httpResponse = response as? HTTPURLResponse {
					if httpResponse.statusCode != 200 {
						completionHandler(self.getError(statusCode: httpResponse.statusCode, data: data!))
						return
					}
				}
				
				if let error = self.parseAsError(data: data!) {
					completionHandler(error)
					return
				}
				
				completionHandler(nil)
				return
			}
		}
		
		dataTask.resume()
	}
	
	static func getByLoggingIn(user: LoginUser, completionHandler: @escaping (Result<BackendMiddleware, Error>) -> ()) {
		login(user: user) { result in
			switch result {
				case .success(let token):
					completionHandler(.success(BackendMiddleware(token: token.token)))
				case .failure(let error):
					completionHandler(.failure(error))
			}
		}
	}
	
	static func login(user: LoginUser, completionHandler: @escaping (Result<Token, Error>) -> ()) {
		let backendMiddleware = BackendMiddleware(token: "")
		
		backendMiddleware.loginUser(user: user, completionHandler: completionHandler)
	}
	
	static func signup(user: NewUser, completionHandler: @escaping (Error?) -> ()) {
		let backendMiddleware = BackendMiddleware(token: "")
		
		backendMiddleware.signupUser(user: user, completionHandler: completionHandler)
	}
	
	private func parseAsError(data: Data) -> Error? {
		do {
			let jsonDecoder = JSONDecoder()
			let error = try jsonDecoder.decode(Error.self, from: data)
			return NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: error.reason])
		} catch {
			return nil
		}
	}
	
	private func getError(statusCode: Int, data: Data) -> Error {
		return NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: parseAsError(data: data)?.localizedDescription ?? String(data: data, encoding: .utf8)!])
	}
}
