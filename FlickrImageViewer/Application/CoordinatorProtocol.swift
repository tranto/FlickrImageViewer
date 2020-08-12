//
//  CoordinatorProtocol.swift
//  FlickrImageViewer
//
//  Created by Tran To on 11/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import SwiftUI

protocol CoordinatorProtocol {
	associatedtype DisplayView: View
	func start() -> DisplayView
    func shouldDismiss()
	
}

extension CoordinatorProtocol {
	func shouldDismiss() {}
	
	func coordinate<T: CoordinatorProtocol>(to coordinator: T) -> some View {
		return coordinator.start()
	}
	
}
