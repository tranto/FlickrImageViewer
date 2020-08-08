//
//  LocationManagerProtocol.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import CoreLocation

protocol LocationManagerProtocol {
	
    var location: CLLocation? { get }
	var distanceFilter: CLLocationDistance { get set }
    var delegate: CLLocationManagerDelegate? { get set }
    var pausesLocationUpdatesAutomatically: Bool { get set }
    var allowsBackgroundLocationUpdates: Bool { get set }

    // CLLocationManager Methods
    func requestWhenInUseAuthorization()
	func requestAlwaysAuthorization()
    func startUpdatingLocation()
    func stopUpdatingLocation()
	
	func getAuthorizationStatus() -> CLAuthorizationStatus
    func isLocationServicesEnabled() -> Bool
}

extension CLLocationManager: LocationManagerProtocol {
	
	func getAuthorizationStatus() -> CLAuthorizationStatus {
        return CLLocationManager.authorizationStatus()
    }

    func isLocationServicesEnabled() -> Bool {
        return CLLocationManager.locationServicesEnabled()
    }
}
