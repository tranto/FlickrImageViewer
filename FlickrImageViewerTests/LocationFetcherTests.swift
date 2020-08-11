//
//  LocationFetcherTests.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import XCTest
@testable import FlickrImageViewer
import Combine

class LocationFetcherTests: XCTestCase {
	
	let locationManager: MockLocationManager = MockLocationManager()
	var sut: LocationManager!
	override func setUpWithError() throws {
		sut = LocationManager(locationMgr: locationManager)
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	func testDisableService() throws {
		sut.disable()
		let result = locationManager.isLocationServicesEnabled()
		XCTAssertFalse(result, "The location service isn't disabled")
	}
	
	func testEnableService() throws {
		sut.enable()
		let expected = locationManager.isLocationServicesEnabled()
		XCTAssertTrue(expected, "The location isn't enabled")
	}
}
