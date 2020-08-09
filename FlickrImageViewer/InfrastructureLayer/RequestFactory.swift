//
//  RequestBuilder.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

protocol RequestFactoryProtocol: class {
	 func makeSearchPhotosRequestWith(location: Location) throws -> URLComponents
	 func makeSearchPhotosRequestWith(tags: [String], location: Location) throws -> URLComponents
}

class RequestFactory: RequestFactoryProtocol {
	
	private let configuration: ConfigurationManagerProtocol
	
	init(config: ConfigurationManagerProtocol) {
		self.configuration = config
	}
	
	public func makeSearchPhotosRequestWith(location: Location) throws -> URLComponents {
		return try self.makeSearchPhotosRequestWith(tags: [], location: location)
	}
	
	func makeSearchPhotosRequestWith(tags: [String], location: Location) throws -> URLComponents {
		let tagsInStr = tags.joined(separator: ",")
		let payload = SearchPhotoPayload(perPage: nil, radiusUnits: "km", lat: String(format: "%f", location.lat), lon: String(format: "%f", location.lon), tags: tagsInStr, sort: nil, contentType: nil, tagMode: nil)
		let photoRequest = SearchPhotos(baseURL: configuration.baseURL, searchPhotoPayload: payload, path: configuration.flickrServicePath ,apiKey: configuration.apiKey)
		return try createURLRequest(from: photoRequest)
	}
	
	private func createURLRequest(from request: NetworkRequestProtocol) throws -> URLComponents  {
		
		guard let baseUrl = URL(string: request.baseURLString) else {
			throw InfrastructureError.invalidRequest(description: "Invalid base url: %@".localized(arguments: request.baseURLString))
		}
		
		var url = baseUrl
		if let path = request.path {
			url = url.appendingPathComponent(path)
		}
		
		var urlRequest = URLRequest(url: url)
		
		urlRequest.httpMethod = request.method.rawValue
		
		if let headers = request.headers {
			for header in headers {
				urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
			}
		}
		
		var components = URLComponents()
		components.scheme = urlRequest.url?.scheme
		components.host = urlRequest.url?.host
		components.path = urlRequest.url?.path ?? ""
		
		components.queryItems = request.parameters?.compactMap({ (key, value) -> URLQueryItem? in
			let valStr = (value as AnyObject).description
			return URLQueryItem(name: key, value: valStr)
		})

		return components
	}
}
