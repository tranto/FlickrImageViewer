//
//  GalleryViewModel.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI
import Combine

class GalleryViewModel: ObservableObject, Identifiable {
	
	private let locationFetcher: LocationFetcherProtocol
	private let photoManager: PhotoManagerProtocol
	private var disposables = Set<AnyCancellable>()
	var searchResult : [Photo] = []
	@Published var currentLocation: Location = Location(lon: 0, lat: 0)
	@Published var tags: String = ""
	@Published private(set) var state = State()
	@Published var photoURLs: [URL] = []
	@Published var selectedPhoto: Photo?
	
	struct State {
		var page: Int = 1
		var canLoadNextPage = true
	}
	
	var screenTitle: String {
		return "Gallery".localized + " 🏷"
	}
	
	init(locationFetcher: LocationFetcherProtocol, scheduler: DispatchQueue = DispatchQueue(label: String(describing: GalleryViewModel.self)),
		 photoManager: PhotoManagerProtocol) {
		
		self.locationFetcher = locationFetcher
		self.photoManager = photoManager
		fetchCurrentLocation()
		
		$tags.dropFirst(1)
			.debounce(for: .seconds(0.5), scheduler: scheduler)
			.sink(receiveValue: searchPhotoWithCurrentLocationAndTags(tags:))
			.store(in: &disposables)
	}
	
	func fetchCurrentLocation() {
		if locationFetcher.isAccessable {
			locationFetcher.enable()
			locationFetcher.currentLocation.receive(on: DispatchQueue.main)
				.sink(
					receiveCompletion: { _ in },
					receiveValue: { [weak self] location in
						guard let self = self else { return }
						self.currentLocation = location
						self.loadPhotoWith(location: location, tags: [], at: self.state.page)
						self.locationFetcher.disable()
					}
				)
				.store(in: &disposables)
		}
	}
	
	func loadPhotoWith(location: Location, tags: [String], at page: Int) {
		loadMorePhotoWith(location: location, tags: tags, page: page)
	}
	
	func searchPhotoWithCurrentLocationAndTags(tags: String) {
		DispatchQueue.main.async {
			self.photoURLs.removeAll()
			self.state.canLoadNextPage = false
			self.state.page = 1
		}
		loadMorePhotoWith(location: currentLocation, tags: [tags], page: self.state.page)
	}
	
	private func loadMorePhotoWith(location: Location, tags: [String], page: Int) {
		photoManager.loadMorePhotos(tags: tags, location: location, page: page)
		.map({ result in
			result.photos.photo
		})
		.receive(on: DispatchQueue.main)
		.sink(
			receiveCompletion: { value in
				switch value {
				case .failure:
					self.state.canLoadNextPage = false
					break
				case .finished:
					break
				}
		},
			receiveValue: { [weak self] photos in
				guard let self = self else { return }
				self.searchResult.append(contentsOf:  photos)
				self.photoURLs.append(contentsOf:  photos.compactMap({ return URL(string: Parser.thumbnailUrlPath(photo: $0)) }))
				self.state.canLoadNextPage = photos.count > 0
				self.state.page += 1
		})
		.store(in: &disposables)
	}
}
