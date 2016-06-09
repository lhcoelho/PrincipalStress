//
//  Stresses_3DUITests.swift
//  Stresses 3DUITests
//
//  Created by Lucas Coelho on 6/9/16.
//  Copyright © 2016 Luiz Herkenhoff Coelho. All rights reserved.
//

import XCTest

class Stresses_3DUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLabelsAreNotMinusZero() {
        // Arrange + Act
        let app = XCUIApplication()
        let textField = app.textFields["σx"]
        textField.tap()
        textField.typeText("45")
        
        // Assert
        let allLabels = app.descendantsMatchingType(.StaticText)
        
        for index in 0..<allLabels.count {
            let label = allLabels.elementBoundByIndex(index)
            XCTAssertNotEqual(label.label, "-0.00")
        }
    }
}