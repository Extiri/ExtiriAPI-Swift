//
//  Models.swift
//  
//
//  Created by Wiktor Wójcik on 22/02/2022.
//

import Foundation

public class BMSnippet: Codable {
	public var id: String
	public var title: String
	public var desc: String
	public var code: String
	public var creator: String
	public var creationDate: Date
}

public class BMToken: Codable {
	var token: String
}

public class BMError: Codable {
	var reason: String
	var error: Bool
}

public class BMUser: Codable {
	public var id: String
	public var name: String
}

public class BMNewUser: Codable {
	init(name: String, email: String, password: String) {
		self.name = name
		self.email = email
		self.password = password
	}
	
	public var name: String
	public var email: String
	public var password: String
}

public class BMLoginUser: Codable {
	init(email: String, password: String) {
		self.email = email
		self.password = password
	}
	
	public var email: String
	public var password: String
}

public class BMNewSnippet: Codable {
	public init(title: String, description: String, code: String) {
		self.title = title
		self.description = description
		self.code = code
	}
	
	public var title: String
	public var description: String
	public var code: String
}

public class BMInfoUser: Codable {
	var id: UUID
	var name: String
	var email: String
	
	init(id: UUID, name: String, email: String) {
		self.id = id
		self.name = name
		self.email = email
	}
}
