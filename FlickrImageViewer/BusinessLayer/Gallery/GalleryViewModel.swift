//
//  GalleryViewModel.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI
import Combine
import CoreLocation

class GalleryViewModel: ObservableObject, Identifiable {
	
	private let locationFetcher: LocationFetchable
	private var disposables = Set<AnyCancellable>()
	@Published var content: GalleryContentModel = GalleryContentModel()
	@Published var tags: String = ""
	
	init(locationFetcher: LocationFetchable, scheduler: DispatchQueue = DispatchQueue(label: String(describing: GalleryViewModel.self))) {
		self.locationFetcher = locationFetcher
		self.fetchCurrentLocation()
	}
	
	func fetchCurrentLocation() {
		locationFetcher.currentLocation
			.map { response in
				GalleryContentModel(item: response)
		}
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
			receiveValue: { [weak self] contentModel in
				guard let self = self else { return }
				self.content = contentModel
		})
			.store(in: &disposables)
	}
	
}


