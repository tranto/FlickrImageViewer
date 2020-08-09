//
//  RequestBuilder.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

class RequestFactory: NSObject {
	
	static func createURLRequest(from request: NetworkRequestProtocol) throws -> URLComponents  {
		
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
			return URLQueryItem(name: key, value: value as? String)
		})

		return components
	}
}
