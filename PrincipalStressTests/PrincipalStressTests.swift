//
//  PrincipalStressTests.swift
//  PrincipalStressTests
//
//  Created by Luiz Herkenhoff Coelho on 09/05/16.
//  Copyright © 2016 Luiz Herkenhoff Coelho. All rights reserved.
//

import XCTest
@testable import PrincipalStress

class PrincipalStressTests: XCTestCase {
    
    var sut = ViewController()
    
    override func setUp() {
        super.setUp()
        
        sut = ViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testOrderValuesWithZeroZeroZero() {
        let arrayIn: [Double] = [0, 0, 0]
        let expectedArray: [Double] = [0, 0, 0]
        
        let arrayOut = sut.orderValues(arrayIn)
        XCTAssertEqual(arrayOut, expectedArray)
    }
    
    func testOrderValuesWith032() {
        let arrayIn: [Double] = [0, 3, 2]
        let expectedArray: [Double] = [3, 2, 0]
        
        let arrayOut = sut.orderValues(arrayIn)
        XCTAssertEqual(arrayOut, expectedArray)
    }
    
    func testOrderValuesWith023() {
        let arrayIn: [Double] = [0, 2, 3]
        let expectedArray: [Double] = [3, 2, 0]
        
        let arrayOut = sut.orderValues(arrayIn)
        XCTAssertEqual(arrayOut, expectedArray)
    }
    
    func testOrderValuesWith0Minus23() {
        let arrayIn: [Double] = [0, -2, 3]
        let expectedArray: [Double] = [3, 0, -2]
        
        let arrayOut = sut.orderValues(arrayIn)
        XCTAssertEqual(arrayOut, expectedArray)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
