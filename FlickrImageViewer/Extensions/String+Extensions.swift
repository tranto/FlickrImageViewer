//
//  String+Extensions.swift
//  FlickrImageViewer
//
//  Created by Tran To on 9/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

extension String {
	
	var localized: String {
        return NSLocalizedString(self, comment: "")
    }
	
	func localized(arguments: CVarArg...) -> String {
		let formatString = NSLocalizedString(self, comment: "")
		return String(format: formatString, arguments: arguments)
	}
 }
