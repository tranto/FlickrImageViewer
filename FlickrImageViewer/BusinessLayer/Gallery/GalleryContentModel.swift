//
//  GalleryItemViewModel.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

struct GalleryContentModel {
	
	private let currentLocation: Location
	
	var location: String {
		return "Latitute = \(currentLocation.lat) \nLongtitude = \(currentLocation.lon)"
	 }
	
	var screenTitle: String {
		return "Gallery 🏷"
	}
	
	init(item: Location = Location(lon: 0, lat: 0)) {
	   self.currentLocation = item
	}
}
