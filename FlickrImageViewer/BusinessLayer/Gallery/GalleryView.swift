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
    
	var body: some View {
		NavigationView {
			List {
				searchField
				if viewModel.photos.count > .zero {
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
			TextField("Tags: Sydney", text: $viewModel.tags)
		}
	}
	
	var photoGrid: some View {
		PhotoGridView(downloadedImages: viewModel.photos)
			.aspectRatio(contentMode: .fit)
	}
	
	var result: some View {
	  Section {
	   Text("Searching Photos...")
		  .foregroundColor(.gray)
	  }
	}
}
