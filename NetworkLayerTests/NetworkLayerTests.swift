//
//  NetworkLayerTests.swift
//  NetworkLayerTests
//
//  Created by Ryan Ofori on 4/18/20.
//  Copyright © 2020 Ryan Ofori. All rights reserved.
//

import XCTest
@testable import NetworkLayer

class NetworkLayerTests: XCTestCase {
    let manage = NetworkManager.shared
//    let mock: MockSession
    
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
    
    func testURL() {
//        manage.networkURL(url: "www.google.com")
        
    }
    
    func testGet() {
        //dependacy inject -> protocol and urlSession
//        let mock = 
        let url = ""
//        let invaidURL = "ksdjfhl"
        var realData: Data?
//        manage.getData(urlString: invaidURL) { (data) in
//            let mockData = String(decoding: data, as: UTF8.self)
//        }
        manage.getData(urlString: url) { (data) in
            realData = data
        }
        XCTAssertNotNil(realData)
//        manage.getData(urlString: url) { (data) in
//            if let jsonString = String(data: data, encoding: .utf8){
//
//
//            }
//        }

    }

//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
