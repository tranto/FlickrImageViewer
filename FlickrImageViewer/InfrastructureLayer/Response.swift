//
//  Response.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

struct Location: Codable, Equatable {
	let lon: Double
	let lat: Double
	
	static func ==(lhs: Location, rhs: Location) -> Bool {
		return lhs.lon == rhs.lon && lhs.lat == rhs.lat
	}
}

struct Photo: Codable {
	let id: String
	let owner: String
	let secret: String
	let server: String
	let farm: Int
	let title: String
	let ispublic: Int
	let isfriend: Int
	let isfamily: Int
}

struct Photos: Codable {
	let page: Int
	let pages: Int
	let perpage: Int
	let total: String
	let photo: [Photo]
}

struct SearchPhotoResponse: Codable {
	let photos: Photos
	let stat: String
}
