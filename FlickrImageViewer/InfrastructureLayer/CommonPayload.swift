//
//  CommonPayload.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

struct CommonAPIParams: Codable, JsonParserable {
	let format: String
	let nojsoncallback: Int
	let method: String
	let apiKey: String
	
	
	init(method: String, apiKey: String) {
		self.method = method
		format = "json"
		nojsoncallback = 1
		self.apiKey = apiKey
	}
}

struct SearchPhotoPayload: Codable, JsonParserable {
	let perPage: Int?
	let radiusUnits: String?
	let lat: String
	let lon: String
	let tags: String?
	let sort: String?
	let contentType: Int?
	let tagMode: String?
}

protocol JsonParserable: Codable {
	func dictValue() throws -> [String: Any]
}

extension JsonParserable {
	
	func dictValue() throws -> [String: Any] {
		let encoder: JSONEncoder = JSONEncoder()
		encoder.keyEncodingStrategy = .convertToSnakeCase
		let data = try encoder.encode(self)
		guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
			throw InfrastructureError.parsing(description: "Cannot encode object to dict".localized)
		}
		return dictionary
	}
}
