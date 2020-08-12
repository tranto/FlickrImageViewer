//
//  ApplicationCoordinator.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI

final class AppCoordinator: CoordinatorProtocol {
	
    private weak var window: UIWindow?
	private lazy var locationManager: LocationFetcherProtocol = {
		return LocationFetcher()
	}()
	
	private lazy var photoManager: PhotoManagerProtocol = {
		return PhotoManager(configurationManager: self.configurationManager)
	}()
	
	private lazy var configurationManager: ConfigurationManagerProtocol = {
		return ConfigurationManager(bundle: .main)
	}()
	
    init(window: UIWindow) {
        self.window = window
    }
    
	@discardableResult
	func start() -> some View {
		let factory = MasterFactory(locationFetcher: locationManager, photoManager: photoManager)
		let coordinator = RootMasterCoordinator(window: window, factory: factory)
		return coordinate(to: coordinator)
    }
	
	func shouldDismiss() {
		
	}
}
