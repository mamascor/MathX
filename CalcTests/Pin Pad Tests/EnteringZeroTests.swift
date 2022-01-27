//
//  EnteringZeroTests.swift
//  CalcTests
//
//  Created by iOSB Free on 27/01/2022.
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
//  ♥️ iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's our testing team! They are testing what happens when the user presses 0 on the pin pad.
//   💡 Career Tip 👉🏻 Writing unit tests prevents your work being rejected by the testing
//   department, which means you can become a reliable and dependable member of the team.
// *******************************************************************************************


import XCTest
@testable import Calc

class EnteringZeroTests: XCTestCase {

    // MARK: - Operands - Left
    
    func test0_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func test00_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func test000_LeftHandEntry() throws {
        // Input: 000       Expected Display: 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    // MARK: - Operands - Right
    
    func test0_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func test00_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func test000_RightHandEntry() throws {
        // Input: 000       Expected Display: 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func test000Addition_RightHandEntry() throws {
        // Input: 000       Expected Display: 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func test000Subtraction_RightHandEntry() throws {
        // Input: 000       Expected Display: 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func test000Divide_RightHandEntry() throws {
        // Input: 000       Expected Display: 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal.nan) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "Error")
    }
    
    func test000Multiply_RightHandEntry() throws {
        // Input: 000       Expected Display: 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.multiplyPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(0.0)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }

}
