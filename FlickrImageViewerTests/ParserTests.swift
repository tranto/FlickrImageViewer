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
		XCTAssertEqual(reponse.photos.total, "28013")
    }

}
