//
//  MockLocationManager.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//
import CoreLocation
import Combine
@testable import FlickrImageViewer

class MockLocationManager: LocationManagerProtocol {
	
	var location: CLLocation? = CLLocation(
		latitude: 37.3317,
		longitude: -122.0325086
	)
	
	private var serviceEnabled: Bool = false
	
	var distanceFilter: CLLocationDistance = 10
	
	var delegate: CLLocationManagerDelegate?
	
	var pausesLocationUpdatesAutomatically: Bool = false
	
	var allowsBackgroundLocationUpdates: Bool = true
	
	func requestWhenInUseAuthorization() {}
	
	func requestAlwaysAuthorization() {}
	
	func startUpdatingLocation() {
		serviceEnabled = true
	}
	
	func stopUpdatingLocation() {
		serviceEnabled = false
	}
	
    func getAuthorizationStatus() -> CLAuthorizationStatus {
        return .authorizedWhenInUse
    }

    func isLocationServicesEnabled() -> Bool {
        return serviceEnabled
    }
}
