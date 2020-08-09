//
//  NetworkRequestProtocol.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

public enum HTTPRequestType: String {
    case get = "GET"
}

public enum ParameterEncodingType {
    case json
    case urlQueryString
}

public protocol NetworkRequestProtocol {

    var baseURLString: String { get }
    var method: HTTPRequestType { get }
    var path: String? { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
    var numberOfRetries: UInt? { get }
    var encodingType: ParameterEncodingType { get }
    var destinationURL: URL? { get }
	func shouldRetry(on error: Error) -> Bool
}

public extension NetworkRequestProtocol {
	
    var headers: [String: String]? { return nil }
    
    var numberOfRetries: UInt? {
        return nil
    }
    
    func shouldRetry(on error: Error) -> Bool {
        guard let networkError = error as? InfrastructureError else {
            return false
        }
        
        switch networkError {
        case .server:
            return true
        default:
            return false
        }
    }
    
    var destinationURL: URL? { return nil }
}
