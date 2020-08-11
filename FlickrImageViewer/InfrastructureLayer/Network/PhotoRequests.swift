//
//  PhotoRequests.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

struct SearchPhotos: NetworkRequestProtocol {
	
	var baseURLString: String {
		return privateBaseURL
	}
	
	var method: HTTPRequestType = .get
	
	var path: String? {
		return privatePath
	}
	
	var parameters: [String : Any]? {
		var params: [String: Any] = [:]
		if let common = try? privateCommonPayload.dictValue() {
			params = common
		}
		if let payload = try? privateSearchPhotoPayload.dictValue() {
			params = params.merging(payload, uniquingKeysWith: { (current, adding) in
				current
			})
		}
		return params
	}
	
	var encodingType: ParameterEncodingType = .urlQueryString
	
	private let privateBaseURL: String
	private let privateCommonPayload: CommonAPIParams
	private let privateSearchPhotoPayload: SearchPhotoPayload
	private var privatePath: String?
	
	init(baseURL: String, searchPhotoPayload: SearchPhotoPayload, path: String?, apiKey: String) {
		privateBaseURL = baseURL
		privateCommonPayload = CommonAPIParams(method: "flickr.photos.search", apiKey: apiKey)
		privateSearchPhotoPayload = searchPhotoPayload
		privatePath = path
	}
}

