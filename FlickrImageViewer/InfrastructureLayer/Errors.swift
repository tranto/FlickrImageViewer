//
//  Error.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

enum InfrastructureError: Error {
	case parsing(description: String)
	case locationNotFound(description: String)
	case client(description: String)
	case server(description: String)
	case invalidRequest(description: String)
	case downloadFail(description: String)
}

enum UserInterfaceError: Error {
	case cannotDisplay(description: String)
}
