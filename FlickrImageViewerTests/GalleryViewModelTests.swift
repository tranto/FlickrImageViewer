//
//  GalleryViewModelTests.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 13/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import XCTest
import Combine
@testable import FlickrImageViewer

class GalleryViewModelTests: XCTestCase {

	var mockLocationFetcher: MockLocationFetcher!
	var mockLocationManager: MockLocationManager!
	var mockPhotoManager: MockPhotoManager!
	var sut: GalleryViewModel!
	
    override func setUpWithError() throws {
		mockLocationManager = MockLocationManager()
		mockLocationFetcher = MockLocationFetcher(locationManager: mockLocationManager)
		mockPhotoManager = MockPhotoManager()
		sut = GalleryViewModel(locationFetcher: mockLocationFetcher, photoManager: mockPhotoManager)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
		mockLocationFetcher = nil
    }

    func testFetchCurrentLocation() throws {
		sut.fetchCurrentLocation()
//		XCTAssertEqual(sut.currentLocation.lat, mockLocationManager.location?.coordinate.latitude)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
