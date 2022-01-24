//
//  CalcTests.swift
//  CalcTests
//
//  Created by Matthew Paul Harding on 24/01/2022.
//

import XCTest
@testable import Calc

class CalcTests: XCTestCase {

    func applyPositiveAddition(_ lhs: Int, _ rhd: Int, expected: Double)  {
        
        var calculatorEngine = CalculatorEngine()
        let _ = calculatorEngine.numberPressed(lhs)
        let _ = calculatorEngine.addPressed()
        let _ = calculatorEngine.numberPressed(rhd)
        let result = calculatorEngine.equalsPressed()
        XCTAssertEqual(result, expected)
    }
        
    func testPositiveAddition() throws {
        applyPositiveAddition(1, 1, expected: 2)
        applyPositiveAddition(1, 10, expected: 11)
        applyPositiveAddition(1, 100, expected: 101)
        applyPositiveAddition(1, 1000, expected: 1001)
        applyPositiveAddition(21, 48, expected: 69)
    }

}
