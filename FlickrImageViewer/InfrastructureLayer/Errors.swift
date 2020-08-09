//
//  Error.swift
//  FlickrImageViewer
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

enum LocationError: Error {
	case notFound(description: String)
}

enum ParserError: Error {
	case cannotParse
}
