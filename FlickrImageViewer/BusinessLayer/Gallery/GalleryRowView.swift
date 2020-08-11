//
//  GalleryRowView.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI

struct GridRowView: View {
    
    var itemPerRow: CGFloat
	var contents: [AsyncImage<Image>]
    
    var body: some View {
        HStack(spacing: 1) {
            ForEach(0..<contents.count) { i in
				self.contents[i]
                .frame(
                    width: (UIScreen.main.bounds.width/self.itemPerRow) ,
                    height: UIScreen.main.bounds.width/self.itemPerRow
                )
                .clipped()
            }
		}.aspectRatio(contentMode: .fit)
    }
}
