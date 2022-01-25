//
//  iOSBFreeCalculatorEngine_PositiveAdditionTests.swift
//  CalcTests
//
//  Created by Matthew Paul Harding on 25/01/2022.
//

import XCTest
@testable import Calc

class iOSBFreeCalculatorEngine_PositiveAdditionTests: XCTestCase {

    func testPositiveAddition() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        let lhdValue = calculatorEngine.numberPressed(1)
        let valueWhenAddPressed = calculatorEngine.addPressed()
        let rhdValue = calculatorEngine.numberPressed(1)
        let result = calculatorEngine.equalsPressed()
        
        XCTAssertEqual(lhdValue, 1)
        XCTAssertEqual(valueWhenAddPressed, 1)
        XCTAssertEqual(rhdValue, 1)
        XCTAssertEqual(result, 2)
    }
    
    func testContinuedPositiveAddition() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        let lhdValue = calculatorEngine.numberPressed(1)
        let valueWhenAddPressed = calculatorEngine.addPressed()
        let rhdValue = calculatorEngine.numberPressed(1)
        let result = calculatorEngine.equalsPressed()
        
        XCTAssertEqual(lhdValue, 1)
        XCTAssertEqual(valueWhenAddPressed, 1)
        XCTAssertEqual(rhdValue, 1)
        XCTAssertEqual(result, 2)
        
        // add another value to the result
        let valueWhenAddPressed2 = calculatorEngine.addPressed()
        let rhdValue2 = calculatorEngine.numberPressed(1)
        let result2 = calculatorEngine.equalsPressed()
        
        XCTAssertEqual(valueWhenAddPressed2, result)
        XCTAssertEqual(rhdValue2, 1)
        XCTAssertEqual(result2, 3)
    }

}
