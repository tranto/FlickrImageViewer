//
//  PreviewViewModel.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Combine
import UIKit

class PreviewViewModel {
	
	private var privateImage: UIImage
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
	
	var image: UIImage {
		return privateImage
	}
	
	init(title: String, resolution: String, image: UIImage, id: String, size: String, postedDate: String) {
		self.privateTitle = title
		self.resolution = resolution
		self.privateImage = image
		self.id = id
		self.size = size
		self.postedDate = postedDate
	}
}

