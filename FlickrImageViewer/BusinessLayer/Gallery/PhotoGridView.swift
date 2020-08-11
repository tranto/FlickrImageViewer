//
//  GalleryItemView.swift
//  FlickrImageViewer
//
//  Created by Tran To on 10/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI
import Grid

struct PhotoGridView: View {
	
	@State var style = StaggeredGridStyle(.vertical, tracks: .count(2), spacing: 1)
	var viewModel: PhotoGridViewModel
	var body: some View {
		ScrollView(style.axes) {
			Grid(self.viewModel.images, id: \.self) { index in
				NavigationLink(destination: PreviewView(item: PreviewViewModel(title: "The sydney coffee", resolution: "3000 pixels/inch", imageName: "unsplash\(index)", id: "\(index)", size: "1248 * 1248", postedDate: "2020-19-09"))) {
					Image("unsplash\(index)")
						.renderingMode(.original)
						.resizable()
						.scaledToFit()
				}
			}
			.animation(.easeInOut)
		}
		.gridStyle(
			self.style
		)
	}
}
