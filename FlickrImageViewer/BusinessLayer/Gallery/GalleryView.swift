//
//  GalleryView.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation
import SwiftUI

struct GalleryView: View {
	
	@ObservedObject var viewModel: GalleryViewModel
	
    var body: some View {
        NavigationView {
			List {
				searchField
				result
			}
			.listStyle(GroupedListStyle())
			.navigationBarTitle(viewModel.screenTitle)
		}.navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension GalleryView {
	
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
