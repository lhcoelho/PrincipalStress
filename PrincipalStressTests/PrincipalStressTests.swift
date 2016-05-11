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
    // MARK: - order values
    
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
        // Arrange
        let arrayIn: [Double] = [0, -2, 3]
        let expectedArray: [Double] = [3, 0, -2]
        
        // Act
        let arrayOut = sut.orderValues(arrayIn)
        
        // Assert
        XCTAssertEqual(arrayOut, expectedArray)
    }
    
    // MARK: - principal stresses calculation
    func testInvariantsStressesNormalUse() {
        // Arrange
        let tensionIn = Tension(x: 100, y: 200, z: 150, xy: 50, xz: 70, yz: 120)
        
        // Act
        let invariantsOut = sut.invariantsCalculation(tensionIn)
        
        // Assert
        let I1 = 450.0
        let I2 = 43200.0
        let I3 = 1045000.0
        let expectedInvariant = (I1, I2, I3)
        
        XCTAssertEqual(invariantsOut.0, expectedInvariant.0)
        XCTAssertEqual(invariantsOut.1, expectedInvariant.1)
        XCTAssertEqual(invariantsOut.2, expectedInvariant.2)
    }
    
    func testInvariantsStressesAllZeros() {
        // Arrange
        let tensionIn = Tension(x: 0, y: 0, z: 0, xy: 0, xz: 0, yz: 0)
        
        // Act
        let invariantsOut = sut.invariantsCalculation(tensionIn)
        
        // Assert
        let I1 = 0.0
        let I2 = 0.0
        let I3 = 0.0
        let expectedInvariant = (I1, I2, I3)
        
        XCTAssertEqual(invariantsOut.0, expectedInvariant.0)
        XCTAssertEqual(invariantsOut.1, expectedInvariant.1)
        XCTAssertEqual(invariantsOut.2, expectedInvariant.2)
    }
}
