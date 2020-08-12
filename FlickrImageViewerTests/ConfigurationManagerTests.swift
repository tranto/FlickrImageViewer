//
//  ConfigurationManagerTests.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import XCTest
@testable import FlickrImageViewer

class ConfigurationManagerTests: XCTestCase {

	var sut: ConfigurationManager!
    override func setUpWithError() throws {
		sut = ConfigurationManager()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testFetchingBaseURL() throws {
		let baseURL = sut.baseURL
		let expectedStr = "https://www.flickr.com"
		XCTAssertEqual(expectedStr, baseURL, "The base url is not matching")
    }
    
	func testFetchingAPIKey() throws {
		let apikey = sut.apiKey
		let expectedStr = "d146ca8900c70a658e103863077cf4c3"
		XCTAssertEqual(expectedStr, apikey, "The api key is not matching")
	}
	
	func testFetchingFlickrServicePath() throws {
		let path = sut.flickrServicePath
		let expectedStr = "/services/rest"
		XCTAssertEqual(expectedStr, path, "The path key is not matching")
	}

}
