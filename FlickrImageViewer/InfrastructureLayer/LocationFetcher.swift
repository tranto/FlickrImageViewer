//
//  LocationFetcher.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import CoreLocation
import Combine

protocol LocationFetchable {
	var currentLocation: AnyPublisher<Location, InfrastructureError> { get }
	var isAccessable: Bool { get }
	func enable()
	func disable()
}

class LocationFetcher: NSObject, LocationFetchable {
	
	private var locationManager: LocationManagerProtocol
	private let locationPublisher: PassthroughSubject<Location, InfrastructureError>
	var currentLocation: AnyPublisher<Location, InfrastructureError>
	
	init(locationMgr: LocationManagerProtocol = CLLocationManager()) {
		locationManager = locationMgr
		locationManager.requestAlwaysAuthorization()
		locationPublisher = PassthroughSubject<Location, InfrastructureError>()
		currentLocation = locationPublisher.eraseToAnyPublisher()
		super.init()
		locationManager.delegate = self
	}
	
	var isAccessable: Bool {
		return locationManager.isLocationServicesEnabled()
	}
	
	func enable() {
		locationManager.startUpdatingLocation()
	}
	
	func disable() {
		locationManager.stopUpdatingLocation()
	}
}

extension LocationFetcher: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = manager.location else {
			locationPublisher.send(completion: Subscribers.Completion.failure(InfrastructureError.locationNotFound(description: "Not Found Location".localized)))
			return
		}
		let long = location.coordinate.longitude
		let lat = location.coordinate.latitude
		locationPublisher.send(Location(lon: long, lat: lat))
	}
}
