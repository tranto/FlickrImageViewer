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

struct Photo: Codable, Equatable {
	var id: String
	var owner: String
	var secret: String
	var server: String
	var farm: Int
	var title: String
	var ispublic: Int
	var isfriend: Int
	var isfamily: Int
	
	static func ==(lhs: Photo, rhs: Photo) -> Bool {
		return lhs.id == rhs.id && lhs.secret == rhs.secret
	}
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
