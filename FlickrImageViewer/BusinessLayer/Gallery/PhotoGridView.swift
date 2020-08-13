//
//  PhotoGridView.swift
//  FlickrImageViewer
//
//  Created by Tran To on 10/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI
import UIKit

struct PhotoGridView: View {
	
	@Environment(\.imageCache) var cache: ImageCache
	
	var itemsPerRow = 3
	var downloadingImageURLs: [URL] = []
	var onPhototTapped: ((_ key: String) -> Void)?
	var onLoadMore: ((_ enable: Bool) -> Void)?
	
	var body: some View {
		ScrollView {
			VStack(spacing: .zero) {
				ForEach(.zero..<getRowCount(numerator: downloadingImageURLs.count, denominator: itemsPerRow)) { index in
					GridRowView(itemPerRow: CGFloat(self.itemsPerRow), contents: self.getRowContent(rowNumber: index, itemsPerRow: self.itemsPerRow), onPhotoTapped: self.onPhototTapped).onAppear(perform: {
						self.onLoadMore?(index == 0)
					})
				}
			}
		}
		.aspectRatio(contentMode: .fit)
	}
	
	func getRowCount(numerator: Int, denominator: Int) -> Int {
		if numerator % denominator == 0 {
			return (numerator/denominator)
		} else {
			return (numerator/denominator) + 1
		}
	}
	
	func getRowContent(rowNumber:Int, itemsPerRow:Int) -> [String: AsyncImage<Image>] {
		var returnItems: [String: AsyncImage<Image>] = [:]
		for index in 0..<itemsPerRow {
			let itemIndex = (rowNumber * itemsPerRow) + index
			if itemIndex < downloadingImageURLs.count {
				let urlPath = downloadingImageURLs[itemIndex]
				returnItems[urlPath.absoluteString] = AsyncImage(url: urlPath, cache: self.cache, placeholder: Image("placeholder"), configuration: { $0.resizable() })
			}
		}
		return returnItems
	}
}
