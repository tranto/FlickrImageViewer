//
//  MockPhotoManager.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 13/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Combine
import Foundation
@testable import FlickrImageViewer

class MockPhotoManager: PhotoManagerProtocol {
	func searchPhotos(location: Location) -> AnyPublisher<SearchPhotoResponse, InfrastructureError> {
		let mockReponse = JSONLoader.loadDummyPhotos()
		return Just(mockReponse).setFailureType(to: InfrastructureError.self).eraseToAnyPublisher()
		
	}
	
	func searchPhotos(tags: [String], location: Location) -> AnyPublisher<SearchPhotoResponse, InfrastructureError> {
		let photosData = JSONLoader.load(fileName: "photos")
		let decoder = JSONDecoder()
		let mockReponse = try? decoder.decode(SearchPhotoResponse.self, from: photosData!)
		return Just(mockReponse!).setFailureType(to: InfrastructureError.self).eraseToAnyPublisher()
	}
	
	func loadMorePhotos(location: Location, page: Int) -> AnyPublisher<SearchPhotoResponse, InfrastructureError> {
		let photosData = JSONLoader.load(fileName: "photos")
		let decoder = JSONDecoder()
		let mockReponse = try? decoder.decode(SearchPhotoResponse.self, from: photosData!)
		return Just(mockReponse!).setFailureType(to: InfrastructureError.self).eraseToAnyPublisher()
	}
	
	func loadMorePhotos(tags: [String], location: Location, page: Int) -> AnyPublisher<SearchPhotoResponse, InfrastructureError> {
		let photosData = JSONLoader.load(fileName: "photos")
		let decoder = JSONDecoder()
		let mockReponse = try? decoder.decode(SearchPhotoResponse.self, from: photosData!)
		return Just(mockReponse!).setFailureType(to: InfrastructureError.self).eraseToAnyPublisher()
	}
}
