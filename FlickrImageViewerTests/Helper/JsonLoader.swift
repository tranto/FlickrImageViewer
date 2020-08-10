//
//  JsonLoader.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 10/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import Foundation

final class JSONLoader {
 
	static func load(fileName: String) -> Data? {
		do {
			let bundle = Bundle(for: JSONLoader.self)
			if let path = bundle.path(forResource: fileName, ofType: "json") {
				let url = URL(fileURLWithPath: path)
				let data = try Data(contentsOf: url)
				return data
			}
			return nil
		} catch {
			print(error.localizedDescription)
		}
		return nil
	}
}
