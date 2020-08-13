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
	
	private let photoManager: PhotoManagerProtocol
	private var disposables = Set<AnyCancellable>()
	private var photo: Photo
	
	var thumbnail: URL {
		return URL(string: Parser.thumbnailUrlPath(photo: photo))!
	}
	
	var original: URL {
		return URL(string: Parser.originalUrlPath(photo: photo))!
	}
	
	var title: String {
		return photo.title
	}
	
	init(photo: Photo, photoManager: PhotoManagerProtocol) {
		self.photo = photo
		self.photoManager = photoManager
	}
}

