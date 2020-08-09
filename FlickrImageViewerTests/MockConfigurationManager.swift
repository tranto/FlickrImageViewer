//
//  MockConfigurationManager.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation
@testable import FlickrImageViewer

class MockConfigurationManager: ConfigurationManagerProtocol {
	
	init() {
	}
	
	var apiKey: String {
		return "abc"
	}
	
	var baseURL: String {
		return "https://google.com"
	}
	
	var flickrServicePath: String {
		return "search"
	}
}
