//
//  TestServiceManager.swift
//  weatherAppTests
//
//  Created by Gomez David Diego on 15/09/2019.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//


import XCTest
@testable import weatherApp

class TestServiceManager: XCTestCase {
    private let endPoint = "\(API_URL)/current?city=Raleigh,NC&key=\(API_KEY)"
    
    //testing real APIClient
    //let retrieveApiClient = ServiceManager()
    
    //testing mock APIClient
    let retrieveApiClient = MockServiceManager()
    
    func testRetrieveData() {
        //uncomment the following two lines, when mock test is used.
        retrieveApiClient.reset()
        retrieveApiClient.shouldReturnError = false
        
        let expectation = self.expectation(description: "I expect to receive Data")
        
        retrieveApiClient.retrieveJSON(url: endPoint) { (json, error) in
            //hide loading animation
            
            XCTAssertNil(error)
            guard let json = json?["data"] else {
                XCTFail()
                return
            }
            
            guard let dict = json as? [[String : Any]] else {
                XCTFail()
                return
            }
            
            guard let temp = dict[0]["app_temp"] as? Double else {
                XCTFail()
                return
            }
            print(temp)
            XCTAssertNotNil(temp)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10, handler: nil)
        
    }
    
}

