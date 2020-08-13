//
//  MockLocationFetcher.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 13/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import CoreLocation
import Combine
@testable import FlickrImageViewer

class MockLocationFetcher: LocationFetcherProtocol {
	
	private let locationManager: LocationManagerProtocol!
	init(locationManager: LocationManagerProtocol) {
		self.locationManager = locationManager
	}
	
	var currentLocation: AnyPublisher<Location, InfrastructureError> {
		return Just(Location(lon: self.locationManager.location?.coordinate.longitude ?? 0, lat: self.locationManager.location?.coordinate.latitude ?? 0)).setFailureType(to: InfrastructureError.self).eraseToAnyPublisher()
	}
	
	var isAccessable: Bool {
		self.locationManager.isLocationServicesEnabled()
	}
	
	func enable() {
		//do nothing
	}
	
	func disable() {
		//do nothing
	}
}
