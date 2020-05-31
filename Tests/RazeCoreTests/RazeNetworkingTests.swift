//
//  RazeNetworkingTests.swift
//  RazeCoreTests
//
//  Created by Contingencia IS on 30/05/2020.
//

import XCTest
@testable import RazeCore
final class RazeNetworkingTests: XCTestCase {

    func testLoadDataCall() {
        
        let manager = RazeCore.Networking.Manager()
        let expectation = XCTestExpectation(description: "Called for data")
        guard let url = URL(string: "https//raywenderlinch.com") else {
            return XCTFail("Could not create a URL properly")
        }
        manager.loadData(from: url) {result in
            expectation.fulfill()
            switch result {
            case .success (let returnedData):
                XCTAssertNotNil(returnedData, "Response data is nil")
            case .failure(let error):
                XCTFail(error?.localizedDescription ?? "error forming error")
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }
   

    static var allTests = [
    ("testLoadDataCall", testLoadDataCall)
    ]

}
