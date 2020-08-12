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
		PhotoGridView(downloadedImages: viewModel.photos, callBack:  { key in
//			let viewModel = PreviewViewModel(title: <#T##String#>, resolution: <#T##String#>, image: <#T##UIImage#>, id: <#T##String#>, size: <#T##String#>, postedDate: <#T##String#>)
//			self.coordinator.coordinatortoPreview(viewModel: <#T##PreviewViewModel#>, isPresented: )
			print("I'm here \(key)")
		})
			.aspectRatio(contentMode: .fit)
	}
	
	var result: some View {
	  Section {
	   Text("Searching Photos...")
		  .foregroundColor(.gray)
	  }
	}
}
