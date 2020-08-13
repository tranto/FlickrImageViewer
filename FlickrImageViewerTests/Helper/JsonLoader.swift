//
//  JsonLoader.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 10/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation
@testable import FlickrImageViewer

final class JSONLoader {
 
	static func load(fileName: String) -> Data? {
		do {
			let bundle = Bundle(for: JSONLoader.self)
			if let path = bundle.path(forResource: fileName, ofType: "json") {
				let url = URL(fileURLWithPath: path)
				let data = try Data(contentsOf: url)
				return data
			}
			return nil
		} catch {
			print(error.localizedDescription)
		}
		return nil
	}
	
	static func loadDummyPhotos() -> SearchPhotoResponse {
		let photosData = JSONLoader.load(fileName: "photos")
		let decoder = JSONDecoder()
		return try! decoder.decode(SearchPhotoResponse.self, from: photosData!)
	}
}
