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
	
	private var base: String = ""
	init(base: String = "") {
		self.base = base
	}
	
	var apiKey: String {
		return "abc"
	}
	
	var baseURL: String {
		return base
	}
	
	var flickrServicePath: String {
		return "/search"
	}
}
