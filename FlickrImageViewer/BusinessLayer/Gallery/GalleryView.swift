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
				currentLocation
			}
			.listStyle(GroupedListStyle())
			.navigationBarTitle(viewModel.content.screenTitle)
		}.navigationViewStyle(StackNavigationViewStyle())
    }
}

private extension GalleryView {
	
	var searchField: some View {
		HStack(alignment: .center) {
			TextField("e.g. Tags", text: $viewModel.tags)
		}
	}
	
	var currentLocation: some View {
	   Section {
		Text(viewModel.content.location)
		   .foregroundColor(.gray)
	   }
	 }
}
