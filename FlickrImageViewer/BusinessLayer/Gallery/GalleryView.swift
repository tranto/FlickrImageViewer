//
//  GalleryView.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI

struct GalleryView: View {
	
	@ObservedObject var viewModel: GalleryViewModel
	let coordinator: RootMasterCoordinator
	@State private var willMoveToNextScreen = false
	
	var body: some View {
		NavigationView {
			List {
				searchField
				if viewModel.photoURLs.count > .zero {
					if self.willMoveToNextScreen && self.viewModel.selectedPhoto != nil {
						self.coordinator.coordinatortoPreview(photo: self.viewModel.selectedPhoto!, isPresented: $willMoveToNextScreen)
					}
					photoGrid.listRowInsets(EdgeInsets())
					
				} else {
					result
				}
				
			}.navigationBarTitle(viewModel.screenTitle)
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.background(Color.blue)
	}
}

private extension GalleryView {
	
	var searchField: some View {
		HStack(alignment: .center) {
			TextField("Tags: Sydney".localized, text: $viewModel.tags)
		}
	}
	
	var photoGrid: some View {
		PhotoGridView(downloadingImageURLs: viewModel.photoURLs, onPhototTapped:  { key in
			guard let photo = self.viewModel.searchResult.filter({ key == Parser.thumbnailUrlPath(photo: $0)}).first else { return }
			self.willMoveToNextScreen = true
			self.viewModel.selectedPhoto = photo
		}, onLoadMore: { enable in
			//call load more
		}).aspectRatio(contentMode: .fit)
	}
	
	var result: some View {
		Section {
			Text("Searching Photos...".localized).foregroundColor(.gray)
		}
	}
}
