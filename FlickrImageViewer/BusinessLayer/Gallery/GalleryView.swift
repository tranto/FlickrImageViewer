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
	
	var body: some View {
		NavigationView {
			List {
				searchField
				if viewModel.photoURLs.count > .zero {
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
		}).aspectRatio(contentMode: .fit)
	}
	
	var result: some View {
		Section {
			Text("Searching Photos...".localized).foregroundColor(.gray)
		}
	}
}
