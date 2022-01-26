//
//  NegateButtonTests.swift
//  CalcTests
//
//  Created by Matthew Paul Harding on 26/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//  Tell us what you want to learn  → community@iosbfree.com
// *******************************************************************************************

import XCTest
@testable import Calc

class NegateButtonTests: XCTestCase {

    func testNegatingAResult() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let result1 = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd1 = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(rhd1.isEqual(to: Decimal(1)))
        XCTAssertTrue(result1.isEqual(to: Decimal(2)))
        
        
        calculatorEngine.negatePressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: result1 * -1))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation  == nil)
    }
}
