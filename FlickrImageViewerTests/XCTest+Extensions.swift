//
//  XCTest+Extensions.swift
//  FlickrImageViewerTests
//
//  Created by Tran To on 8/8/20.
//  Copyright © 2020 Tran To. All rights reserved.
//

import XCTest
import Combine

extension XCTestCase {
	
	typealias CompetionResult = (expectation: XCTestExpectation,
		cancellable: AnyCancellable)
	func expectCompletion<T: Publisher>(of publisher: T,
										timeout: TimeInterval = 2,
										file: StaticString = #file,
										line: UInt = #line) -> CompetionResult {
		let exp = expectation(description: "Successful completion of " + String(describing: publisher))
		let cancellable = publisher
			.sink(receiveCompletion: { completion in
				if case .finished = completion {
					exp.fulfill()
				}
			}, receiveValue: { _ in })
		return (exp, cancellable)
	}
	
	func expectValue<T: Publisher>(of publisher: T,
								   timeout: TimeInterval = 2,
								   file: StaticString = #file,
								   line: UInt = #line,
								   equals: [T.Output]) -> CompetionResult where T.Output: Equatable {
		let exp = expectation(description: "Correct values of " + String(describing: publisher))
		var mutableEquals = equals
		let cancellable = publisher
			.sink(receiveCompletion: { _ in },
				  receiveValue: { value in
					if value == mutableEquals.first {
						mutableEquals.remove(at: 0)
						if mutableEquals.isEmpty {
							exp.fulfill()
						}
					}
			})
		return (exp, cancellable)
	}

}

