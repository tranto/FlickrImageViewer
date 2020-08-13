//
//  PreviewView.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI

struct PreviewView: View {
	@Environment(\.imageCache) var cache: ImageCache
	var item: PreviewViewModel
	var body: some View {
		ZStack(alignment: .bottom, content: {
			AsyncImage(url: item.original, cache: self.cache,
					   placeholder: Image("placeholder")  ,
					   configuration: { $0.resizable() })
			Rectangle()
				.frame(height: 80)
				.opacity(0.25).blur(radius: 10)
			HStack {
				VStack(alignment: .leading, spacing: 8.0) {
					Text(item.title)
						.font(.largeTitle)
						.foregroundColor(.white)
				}.padding(.leading)
					.padding(.bottom)
				Spacer()
			}
		}).padding(.top)
	}
}
