//
//  FilimoVitTests.swift
//  FilimoVitTests
//
//  Created by Ehsan Askari on 7/16/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import XCTest
@testable import FilimoVit

class FilimoVitTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPI() {
        APIManager.request(endpoint: "/movie/movie/list/tagid/1", httpMethod: .get) { (result) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func testAPIEndpoint() {
        APIManager.request(endpoint: "/movie/movi/lst/tad/1", httpMethod: .get) { (result) in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
                XCTAssertEqual(error.localizedDescription, "notFound")
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
