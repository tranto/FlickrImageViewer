//
//  JsonParserableTests.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import XCTest
@testable import FlickrImageViewer

class JsonParserableTests: XCTestCase {

	func testCommonAPIParamsToDict() throws {
		let commonPayload = CommonAPIParams(method: "abc", apiKey: "avc")
		let result = try commonPayload.dictValue()
		XCTAssertEqual(result["api_key"] as! String, "avc")
		XCTAssertEqual(result["method"] as! String, "abc")
		XCTAssertEqual(result["format"] as! String, "json")
		XCTAssertEqual(result["nojsoncallback"] as! Int, 1)
	}
	
	func testSearchPhotoPayloadToDict() throws {
		let searchPayload = SearchPhotoPayload(perPage: 100, radiusUnits: "km", lat: "43", lon: "900", tags: "abc", sort: "date-posted-desc", contentType: 7, tagMode: "all", page: 1)
		let result = try searchPayload.dictValue()
		XCTAssertEqual(result["per_page"] as! Int, 100)
		XCTAssertEqual(result["radius_units"] as! String, "km")
		XCTAssertEqual(result["sort"] as! String, "date-posted-desc")
	}
	
	func testSearchPhotoPayloadWithNilValuesToDict() throws {
		let searchPayload = SearchPhotoPayload(perPage: nil, radiusUnits: "km", lat: "678", lon: "900", tags: "abc", sort: "date-posted-desc", contentType: nil, tagMode: nil, page: 1)
		let result = try searchPayload.dictValue()
		XCTAssertNil(result["per_page"], "Per page is not nil")
		XCTAssertEqual(result["radius_units"] as! String, "km")
		XCTAssertEqual(result["page"] as! Int, 1)
		XCTAssertEqual(result["sort"] as! String, "date-posted-desc")
		XCTAssertNil(result["content_type"], "Content type is not nil")
	}

}
