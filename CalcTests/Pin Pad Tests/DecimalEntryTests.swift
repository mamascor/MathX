//
//  DecimalEntryTests.swift
//  CalcTests
//
//  Created by Matthew Paul Harding on 27/01/2022.
//
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

class DecimalEntryTests: XCTestCase {

    // MARK: - Operands - Left
    
    func testSmall_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
    }
    
    func testSmallWithZero_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(0)
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0)))
    }
    
    func testSmallWith1_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(1)
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.1)))
    }
    
    func testMedium_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.1234)))
    }
    
    func testLarge_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(9)
        XCTAssertTrue(calculatorEngine.leftHandOperand.formatted() == Decimal(0.123456789).formatted())
    }
    
    // MARK: - Operands - Right
    
    func testSmall_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
    }
    
    func testSmallWithZero_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(0)
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0)) ?? false)
    }
    
    func testSmallWith1_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(1)
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.1)) ?? false)
    }
    
    func testMedium_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.1234)) ?? false)
    }
    
    func testLarge_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(9)
        XCTAssertTrue(calculatorEngine.rightHandOperand?.formatted() ?? "" == Decimal(0.123456789).formatted())
    }
    
    
    // MARK: - Immediate Press Without Previous Value
    
    func testImmediatePress_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(1)
        XCTAssertTrue(calculatorEngine.leftHandOperand.formatted() == Decimal(0.1).formatted())
    }
    
    func testImmediatePress_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.decimalPressed()
        calculatorEngine.numberPressed(1)
        XCTAssertTrue(calculatorEngine.rightHandOperand?.formatted() ?? "" == Decimal(0.1).formatted())
    }
}
