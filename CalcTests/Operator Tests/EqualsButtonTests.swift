//
//  EqualsButtonTests.swift
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
//
//  Tell us what
//  you want to learn
//
//  💙 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's our testing team! They are testing pressing the equals button.
//   💡 Career Tip 👉🏻 Writing unit tests prevents your work being rejected by the testing
//   department, which means you can become a reliable and dependable member of the team.
// *******************************************************************************************

import XCTest
@testable import Calc

class EqualsButtonTests: XCTestCase {

    // MARK: - Basic Equals
    func testBasicEquals() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(1)))
        XCTAssertTrue(result.isEqual(to: Decimal(0)))
    }
    
    // MARK: - Pressing Equals Again and Again
    
    func testRepeatativeEquals_UsingAddition() throws {
        // Input 4 + 4 = = =
        // Expected Result: (4 + 4), becomes (8 + 4), becomes (12 + 4)
        
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(4)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(4)))
        XCTAssertTrue(result.isEqual(to: Decimal(8)))
        
        
        calculatorEngine.equalsPressed()
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(12)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(4)))
        XCTAssertTrue(result.isEqual(to: Decimal(16)))
    }
    
    func testRepeatativeEquals_UsingSubtraction() throws {
        // Input 4 + 4 = = =
        // Expected Result: (4 + 4), becomes (8 + 4), becomes (12 + 4)
        
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(4)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(4)))
        XCTAssertTrue(result.isEqual(to: Decimal(0)))
        
        
        calculatorEngine.equalsPressed()
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-4)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(4)))
        XCTAssertTrue(result.isEqual(to: Decimal(-8)))
    }
    
    func testRepeatativeEquals_UsingMultiplication() throws {
        // Input 4 + 4 = = =
        // Expected Result: (4 + 4), becomes (8 + 4), becomes (12 + 4)
        
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.multiplyPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(4)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(4)))
        XCTAssertTrue(result.isEqual(to: Decimal(16)))
        
        
        calculatorEngine.equalsPressed()
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(64)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(4)))
        XCTAssertTrue(result.isEqual(to: Decimal(256)))
    }
    
    func testRepeatativeEquals_UsingDivision() throws {
        // Input 4 + 4 = = =
        // Expected Result: (4 + 4), becomes (8 + 4), becomes (12 + 4)
        
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(4)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(4)))
        XCTAssertTrue(result.isEqual(to: Decimal(1)))
        
        
        calculatorEngine.equalsPressed()
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.25)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(4)))
        XCTAssertTrue(result.formatted() ==  Decimal(0.0625).formatted())
    }
}
