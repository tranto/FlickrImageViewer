//
//  PreviewView.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI

struct PreviewView: View {
	
	var item: PreviewViewModel
    var body: some View {
		VStack(alignment: .leading, spacing: 16.0, content: {
			Image(item.imageName)
				.resizable()
				.renderingMode(.original)
				.aspectRatio(contentMode: .fit)
			VStack(alignment: .leading, spacing: 5.0, content: {
				Text(item.title)
					.font(.headline)
					.foregroundColor(.primary)
				Text("\(item.description)")
					.foregroundColor(.secondary)
					.font(.subheadline)
					.multilineTextAlignment(.leading)
			})
		})
    }
}

struct PreviewView_Previews: PreviewProvider {
	static var previews: some View {
		PreviewView(item: PreviewViewModel(title: "The Sydney Coffee", resolution: "3000 pixels/inch", imageName: "unsplash2", id: "324243", size: "1248 * 1248", postedDate: "2020-08-09"))
	}
}
