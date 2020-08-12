//
//  DetailsCoordinator.swift
//  FlickrImageViewer
//
//  Created by Tran To on 12/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI

final class DetailsCoordinator: CoordinatorProtocol {
	
    private let viewModel: PreviewViewModel
    private var isPresented: Binding<Bool>
    
    init(viewModel: PreviewViewModel, isPresented: Binding<Bool>) {
        self.viewModel = viewModel
        self.isPresented = isPresented
    }
    
    @discardableResult
    func start() -> some View {
        let view = PreviewView(item: viewModel)
        return NavigationLinkWrapper(destination: view, isPresented: isPresented)
    }
}
