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

	@Published var currentLocation: Location = Location(lon: 0, lat: 0)
	@Published var tags: String = ""
	@Published private(set) var state = State()
	@Published var photos: [String: UIImage?] = [:]
	
	struct State {
		var photoNames: [String] = []
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
		//$city emits its first value
		$tags
			.dropFirst(1)
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
						self.searchPhotoWithCurrentLocation(location: location)
						self.locationFetcher.disable()
					}
				)
				.store(in: &disposables)
		}
	}
	
	func searchPhotoWithCurrentLocation(location: Location) {
		photoManager.searchPhotos(location: location)
			.map({ result in
				result.photos.photo.map({ return String("https://farm\($0.farm).staticflickr.com/\($0.server)/\($0.id)_\($0.secret)_m.jpg") })
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
				receiveValue: { [weak self] names in
					guard let self = self else { return }
					names.forEach({ self.photos[$0] = UIImage()})
					self.state.canLoadNextPage = names.count > 0
					self.state.page += 1
			})
			.store(in: &disposables)
	}
	
	func searchPhotoWithCurrentLocationAndTags(tags: String) {
		self.photos.removeAll()
		photoManager.searchPhotos(tags: [tags], location: self.currentLocation)
		.map({ result in
			result.photos.photo.map({ return String("https://farm\($0.farm).staticflickr.com/\($0.server)/\($0.id)_\($0.secret)_m.jpg") })
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
			receiveValue: { [weak self] names in
				guard let self = self else { return }
				names.forEach({ self.photos[$0] = UIImage()})
				self.state.canLoadNextPage = names.count > 0
				self.state.page += 1
		})
		.store(in: &disposables)
	}
	
	func fetchNextPageIfPossible() {
		guard state.canLoadNextPage else { return }
	}
}
