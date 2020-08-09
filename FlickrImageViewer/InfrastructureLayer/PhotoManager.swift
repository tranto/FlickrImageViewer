//
//  PhotoManager.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//
import Foundation
import Combine

protocol PhotoManagerProtocol: class {
	func searchPhotos(location: Location) -> AnyPublisher<Photos, InfrastructureError>
	func searchPhotos(tags: [String], location: Location) -> AnyPublisher<Photos, InfrastructureError>
}

class PhotoManager: PhotoManagerProtocol {
	
	private let session: URLSession
	private let config: ConfigurationManagerProtocol
	private let requestFactory: RequestFactoryProtocol
	init(session: URLSession = .shared, configurationManager: ConfigurationManagerProtocol) {
		self.session = session
		self.config = configurationManager
		requestFactory = RequestFactory(config: config)
	}
	
	func searchPhotos(location: Location) -> AnyPublisher<Photos, InfrastructureError> {
		guard let components = try? requestFactory.makeSearchPhotosRequestWith(location: location),
			let url = components.url else {
				let error = InfrastructureError.client(description: "Cannot create url".localized)
				return Fail(error: error).eraseToAnyPublisher()
		}
		
		return session.dataTaskPublisher(for: URLRequest(url: url))
			.mapError { error in
				InfrastructureError.server(description: error.localizedDescription)
		}
		.flatMap(maxPublishers: .max(1)) { pair in
			Parser.decode(pair.data)
		}
		.eraseToAnyPublisher()
	}
	
	func searchPhotos(tags: [String], location: Location) -> AnyPublisher<Photos, InfrastructureError> {
		
		guard let components = try? requestFactory.makeSearchPhotosRequestWith(tags: tags, location: location),
			let url = components.url else {
				let error = InfrastructureError.client(description: "Cannot create url".localized)
				return Fail(error: error).eraseToAnyPublisher()
		}
		
		return session.dataTaskPublisher(for: URLRequest(url: url))
			.mapError { error in
				InfrastructureError.server(description: error.localizedDescription)
		}
		.flatMap(maxPublishers: .max(1)) { pair in
			Parser.decode(pair.data)
		}
		.eraseToAnyPublisher()
	}
	
}
