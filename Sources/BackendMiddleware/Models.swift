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

public class BMUser: Codable {
	public var id: String
	public var name: String
	public var email: String
}

public class BMNewUser: Codable {
	public var name: String
	public var email: String
	public var password: String
}

public class BMLoginUser: Codable {
	public var email: String
	public var password: String
}

public class BMNewSnippet: Codable {
	public var title: String
	public var description: String
	public var code: String
	
	public init(title: String, description: String, code: String) {
		self.title = title
		self.description = description
		self.code = code
	}
}
