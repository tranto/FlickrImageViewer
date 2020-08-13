//
//  Parser.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation
import Combine

class Parser {
	
	static func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, InfrastructureError> {
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .secondsSince1970
		
		return Just(data)
			.decode(type: T.self, decoder: decoder)
			.mapError { error in
				.parsing(description: error.localizedDescription)
		}
		.eraseToAnyPublisher()
	}
	
	static func thumbnailUrlPath(photo: Photo) -> String {
		return String("https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_m.jpg")
	}
	
	static func originalUrlPath(photo: Photo) -> String {
		return String("https://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret)_b.jpg")
	}
}
