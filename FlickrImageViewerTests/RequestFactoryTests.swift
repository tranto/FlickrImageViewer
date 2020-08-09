//
//  RequestFactoryTests.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import XCTest
@testable import FlickrImageViewer

class RequestFactoryTests: XCTestCase {

    func testCreatingSearchPhotosRequestWithLocation() throws {
		//given
		let mockConfig = MockConfigurationManager(base: "https://google.com")
		let sut = RequestFactory(config: mockConfig)
		//when
		let requestComponents = try sut.makeSearchPhotosRequestWith(location: Location(lon: Double(10.8), lat: Double(9.4)))
		//then
		XCTAssertNotNil(requestComponents)
		XCTAssertEqual(requestComponents.path, mockConfig.flickrServicePath)
		XCTAssertEqual((requestComponents.queryItems?.filter({ $0.name == "method"}).first?.value ?? "") as String, "flickr.photos.search")
		XCTAssertEqual((requestComponents.queryItems?.filter({ $0.name == "api_key" }).first?.value ?? "") as String, mockConfig.apiKey)
		XCTAssertEqual((requestComponents.queryItems?.filter({ $0.name == "lon" }).first?.value ?? "") as String, String(format: "%f", 10.8))
		XCTAssertEqual((requestComponents.queryItems?.filter({ $0.name == "lat" }).first?.value ?? "") as String, String(format: "%f", 9.4))
    }
	
	func testCreatingSearchPhotosRequestWithLocationWithoutBaseURL() throws {
		//given
		let mockConfig = MockConfigurationManager(base: "")
		let sut = RequestFactory(config: mockConfig)
		//when
		XCTAssertThrowsError(try sut.makeSearchPhotosRequestWith(location: Location(lon: 10.0, lat: 98.0)), "Error thrown") { (error) in
			XCTAssertEqual(error.localizedDescription, InfrastructureError.invalidRequest(description: "Invalid base url: %@".localized(arguments: "")).localizedDescription)
		}
    }
	
	func testCreatingSearchPhotosRequestWithLocationAndTags() throws {
		//given
		let mockConfig = MockConfigurationManager(base: "https://google.com")
		let sut = RequestFactory(config: mockConfig)
		//when
		let requestComponents = try sut.makeSearchPhotosRequestWith(tags: ["1","2"], location: Location(lon: 100, lat: 98))
		//then
		XCTAssertNotNil(requestComponents)
		XCTAssertEqual(requestComponents.path, mockConfig.flickrServicePath)
		XCTAssertEqual((requestComponents.queryItems?.filter({ $0.name == "method"}).first?.value ?? "") as String, "flickr.photos.search")
		XCTAssertEqual((requestComponents.queryItems?.filter({ $0.name == "api_key" }).first?.value ?? "") as String, mockConfig.apiKey)
		XCTAssertEqual((requestComponents.queryItems?.filter({ $0.name == "tags" }).first?.value ?? "") as String, "1,2")
	}
	
	func testCreatingSearchPhotosRequestWithLocationAndTagsWithoutBaseURL() throws {
		//given
		let mockConfig = MockConfigurationManager(base: "")
		let sut = RequestFactory(config: mockConfig)
		//when
		XCTAssertThrowsError(try sut.makeSearchPhotosRequestWith(location: Location(lon: 10.0, lat: 98.0)), "Error thrown") { (error) in
			XCTAssertEqual(error.localizedDescription, InfrastructureError.invalidRequest(description: "Invalid base url: %@".localized(arguments: "")).localizedDescription)
		}
    }
}
