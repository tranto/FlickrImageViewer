//
//  ParserTests.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 10/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import XCTest
@testable import FlickrImageViewer

class ParserTests: XCTestCase {

    func testSearchPhotoResponseParser() throws {
		let dataReponse = JSONLoader.load(fileName: "Photos")
		let decoder = JSONDecoder()
		XCTAssertNoThrow(try decoder.decode(SearchPhotoResponse.self, from: dataReponse!), "Throw errors")
    }

    func testAccuracyDecoder() throws {
        let dataReponse = JSONLoader.load(fileName: "Photos")
		let decoder = JSONDecoder()
		let reponse = try decoder.decode(SearchPhotoResponse.self, from: dataReponse!)
		XCTAssertEqual(reponse.stat, "ok")
		XCTAssertEqual(reponse.photos.page, 1)
		XCTAssertEqual(reponse.photos.total, 28013)
    }

	func testParserThumbnailUrlPath() {
		let photo  = Photo(id: "124", owner: "344", secret: "242", server: "232", farm: 56, title: "SFDS", ispublic: 1, isfriend: 1, isfamily: 1)
		let result = Parser.thumbnailUrlPath(photo: photo)
		XCTAssertEqual(result, "https://farm56.staticflickr.com/232/124_242_m.jpg")
	}
	
	func testParserOriginalUrlPath() {
		let photo  = Photo(id: "124", owner: "344", secret: "242", server: "232", farm: 56, title: "SFDS", ispublic: 1, isfriend: 1, isfamily: 1)
		let result = Parser.originalUrlPath(photo: photo)
		XCTAssertEqual(result, "https://farm56.staticflickr.com/232/124_242_b.jpg")
	}
}
