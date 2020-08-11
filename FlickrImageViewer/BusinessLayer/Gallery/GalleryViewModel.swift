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
	
	private let locationFetcher: LocationRepositoryProtocol
	private let photoManager: PhotoManagerProtocol
	private var disposables = Set<AnyCancellable>()
	@Published var currentLocation: Location = Location(lon: 0, lat: 0)
	@Published var tags: String = ""
	
	var screenTitle: String {
		return "Gallery".localized + " 🏷"
	}
	
	var photoDataSource: SearchPhotoResponse?
	
	init(locationFetcher: LocationRepositoryProtocol, scheduler: DispatchQueue = DispatchQueue(label: String(describing: GalleryViewModel.self)),
		 photoManager: PhotoManagerProtocol) {
		self.locationFetcher = locationFetcher
		self.photoManager = photoManager
		fetchCurrentLocation()
	}
	
	func fetchCurrentLocation() {
		if locationFetcher.isAccessable {
			locationFetcher.enable()
			locationFetcher.currentLocation
				.receive(on: DispatchQueue.main)
				.sink(
					receiveCompletion: { value in
						switch value {
						case .failure:
							break
						case .finished:
							break
						}
				},
					receiveValue: { [weak self] location in
						guard let self = self else { return }
						self.currentLocation = location
						self.searchPhotoWithCurrentLocation(location: location)
				})
				.store(in: &disposables)
		}
	}
	
	func searchPhotoWithCurrentLocation(location: Location) {
		photoManager.searchPhotos(location: location)
			.receive(on: DispatchQueue.main)
			.sink(
				receiveCompletion: { value in
					switch value {
					case .failure:
						break
					case .finished:
						break
					}
			},
				receiveValue: { [weak self] photos in
					guard let self = self else { return }
					self.photoDataSource = photos
			})
			.store(in: &disposables)
	}
}
