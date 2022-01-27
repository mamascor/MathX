//
//  ClearButtonTests.swift
//  CalcTests
//
//  Created by Matthew Paul Harding on 26/01/2022.
//
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏽 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  🧡 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's our testing team! They are testing pressing the clear button.
//   💡 Career Tip 👉🏻 Writing unit tests prevents your work being rejected by the testing
//   department, which means you can become a reliable and dependable member of the team.
// *******************************************************************************************

import XCTest
@testable import Calc

class ClearButtonTests: XCTestCase {


    // MARK: - Result
    
    func testClear() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(333)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(333)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.clearPressed()
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation == nil)
    }
    
    func testClearAfterPercentage() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(333)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(333)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.percentagePressed()
        
        calculatorEngine.clearPressed()
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation == nil)
    }
    
    func testClearAfterNegate() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(333)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(333)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.negatePressed()
        
        calculatorEngine.clearPressed()
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation == nil)
    }
    
    func testMultipleClear() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(333)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(333)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.clearPressed()
        calculatorEngine.clearPressed()
        calculatorEngine.clearPressed()
        calculatorEngine.clearPressed()
        calculatorEngine.clearPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation == nil)
    }
}
