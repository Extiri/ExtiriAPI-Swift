//
//  Models.swift
//  
//
//  Created by Wiktor Wójcik on 22/02/2022.
//

import Foundation

public class BMSnippetsResponse: Codable {
	public var items: [BMSnippet]
	public var metadata: BMMetadata
}

public class BMMetadata: Codable {
	public var page: Int
	public var per: Int
	public var total: Int
}

public class BMSnippet: Codable {
	public var id: String
	public var title: String
	public var language: String
	public var desc: String
	public var category: String
	public var code: String
	public var creator: String
	public var creationDate: Date
}

public class BMToken: Codable {
	public var token: String
}

public class BMError: Codable {
	public var reason: String
	public var error: Bool
}

public class BMUser: Codable {
	public var id: String
	public var name: String
}

public class BMNewUser: Codable {
	public init(name: String, email: String, password: String) {
		self.name = name
		self.email = email
		self.password = password
	}
	
	public var name: String
	public var email: String
	public var password: String
}

public class BMLoginUser: Codable {
	public init(email: String, password: String) {
		self.email = email
		self.password = password
	}
	
	public var email: String
	public var password: String
}

public class BMNewSnippet: Codable {
	public init(title: String, language: String, category: String, description: String, code: String) {
		self.title = title
		self.description = description
		self.category = category
		self.language = language
		self.code = code
	}
	
	public var title: String
	public var description: String
	public var category: String
	public var language: String
	public var code: String
}

public class BMInfoUser: Codable {
	public init(id: String, name: String, email: String) {
		self.id = id
		self.name = name
		self.email = email
	}
	
	public var id: String
	public var name: String
	public var email: String
}
