//
//  Parser.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation
import Combine

class Parser: NSObject {
	
	static func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, InfrastructureError> {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		decoder.keyDecodingStrategy = .convertFromSnakeCase
		
		return Just(data)
			.decode(type: T.self, decoder: decoder)
			.mapError { error in
				.parsing(description: error.localizedDescription)
		}
		.eraseToAnyPublisher()
	}
}
