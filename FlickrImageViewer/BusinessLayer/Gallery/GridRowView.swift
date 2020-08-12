//
//  GridRowView.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI

struct GridRowView: View {
    
    var itemPerRow: CGFloat
	var contents: [String: AsyncImage<Image>]
	var onPhotoTapped: ((String) -> Void)?
	
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<Array(contents).count) { i in
				Array(self.contents)[i].value
                .frame(
                    width: (UIScreen.main.bounds.width/self.itemPerRow) ,
                    height: UIScreen.main.bounds.width/self.itemPerRow
                )
				.clipped()
				.onTapGesture(perform: {
					self.onPhotoTapped?(Array(self.contents)[i].key)
				})
            }
		}.aspectRatio(contentMode: .fit)
    }
}
