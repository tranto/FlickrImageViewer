//
//  PhotoManagerTests.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import XCTest
@testable import FlickrImageViewer

class PhotoManagerTests: XCTestCase {

	var sut: PhotoManager!
    override func setUpWithError() throws {
		let config = ConfigurationManager()
		sut = PhotoManager(configurationManager: config)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
		var photos = sut.searchPhotos(location: Location(lon: 151.208755, lat: -33.870453))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
