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
				ScrollView(.horizontal)	{
					tagsFilter
				}
				PhotoGridView(viewModel: PhotoGridViewModel())
					.aspectRatio(contentMode: .fill)
			}
			.navigationBarTitle(viewModel.screenTitle)
		}
		.navigationViewStyle(StackNavigationViewStyle())
		.background(Color.blue)
    }
}

private extension GalleryView {
	
	var tagsFilter: some View {
		HStack {
			Button("Amazing"){}
				.padding(8)
				.foregroundColor(.white)
				.background(Color.gray)
				.shadow(radius: 4)
				.cornerRadius(6)
			
			Button("Beautiful"){}
			.padding(8)
			.foregroundColor(.white)
			.background(Color.gray)
			.shadow(radius: 4)
			.cornerRadius(6)
		}
	}
	
	var searchField: some View {
		HStack(alignment: .center) {
			TextField("e.g. Tags", text: $viewModel.tags)
		}
	}
	
	var result: some View {
	   Section {
		Text("Found \(viewModel.photoDataSource?.photos.total ?? "0") Photos")
		   .foregroundColor(.gray)
	   }
	 }
}
