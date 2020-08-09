//
//  ConfigurationManager.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

protocol ConfigurationManagerProtocol {
	var apiKey: String { get }
	var baseURL: String { get }
	var flickrServicePath: String { get }
}

class ConfigurationManager: ConfigurationManagerProtocol {
	
	var apiKey: String {
		return privateBundle.infoDictionary?["Flickr API key"] as? String ?? ""
	}
	
	var flickrServicePath: String {
		return privateBundle.infoDictionary?["Flickr URL path"] as? String ?? ""
	}
	
	var baseURL: String {
		return (privateBundle.infoDictionary?["Base URL"] as? String)?.formatURL ?? ""
	}
	
	private var privateBundle: Bundle
	
	init(bundle: Bundle = Bundle.main) {
		privateBundle = bundle
	}
}
