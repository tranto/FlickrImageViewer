//
//  PreviewViewModel.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Combine

class PreviewViewModel {
	
	private var privateImageName: String
	private var privateTitle: String
	private var resolution: String
	private var id: String
	private var size: String
	private var postedDate: String
	
	var title: String {
		return privateTitle
	}
	
	var description: String {
		return "Resolution: \(resolution) \nSize: \(size) \nPosted date: \(postedDate)"
	}
	
	var imageName: String {
		return privateImageName
	}
	init(title: String, resolution: String, imageName: String, id: String, size: String, postedDate: String) {
		self.privateTitle = title
		self.resolution = resolution
		self.privateImageName = imageName
		self.id = id
		self.size = size
		self.postedDate = postedDate
	}
}
