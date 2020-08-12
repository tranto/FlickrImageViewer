//
//  RootMasterCoordinator.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import UIKit
import SwiftUI

protocol MasterCoordinator: CoordinatorProtocol {}

final class RootMasterCoordinator: MasterCoordinator {
	
    private weak var window: UIWindow?
	private var factory: MasterFactory

	init(window: UIWindow?, factory: MasterFactory) {
        self.window = window
		self.factory = factory
    }
    
    func start() -> some View {
		let view = factory.makeGalleryView(coordinator: self)
        let hosting = UIHostingController(rootView: view)
        window?.rootViewController = hosting
        window?.makeKeyAndVisible()
		return view
    }
	
	func coordinatortoPreview(viewModel: PreviewViewModel, isPresented: Binding<Bool>) -> some View {
		let coordinator = DetailsCoordinator(viewModel: viewModel, isPresented: isPresented)
		return coordinate(to: coordinator)
	}
}

final class MasterFactory {
	
	private var locationFetcher: LocationFetcherProtocol
	private var photoManager: PhotoManagerProtocol
	
	init(locationFetcher: LocationFetcherProtocol, photoManager: PhotoManagerProtocol) {
		self.locationFetcher = locationFetcher
		self.photoManager = photoManager
	}
	
	func makeGalleryView(coordinator: RootMasterCoordinator) -> some View {
		let viewModel = GalleryViewModel(locationFetcher: locationFetcher, photoManager: photoManager)
		let view = GalleryView(viewModel: viewModel, coordinator: coordinator)
        return view
	}
}

struct NavigationLinkWrapper<T: View>: View {
    typealias DestinationView = T
    
    var destination: T
    @Binding var isPresented: Bool
    var isDetailLink: Bool = true
    
    var body: some View {
        NavigationLink(destination: destination, isActive: $isPresented) {
            EmptyView()
        }.isDetailLink(isDetailLink)
    }
}
