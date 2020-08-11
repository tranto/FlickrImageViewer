//
//  PhotoGridViewModel.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Combine

class PhotoGridViewModel {
	
	var images: [Int] = []
	init(range: Range<Int> = Range(1...18)) {
		_ = range.publisher.collect().sink(receiveValue: { self.images = $0})
	}
}
