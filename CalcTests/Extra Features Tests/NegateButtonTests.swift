//
//  NegateButtonTests.swift
//  CalcTests
//
//  Created by iOSB Free on 26/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏿 Free Courses                 → https://www.udemy.com/user/iosbfree
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
//   It's our testing team! They are testing pressing the negate button.
//   Architecural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests prevents your work being rejected by the testing
//   department, which means we can become a dependable member of our team.
// *******************************************************************************************


import XCTest
@testable import Calc

class NegateButtonTests: XCTestCase {

    // MARK: - Operands - Left
    
    func testSmall_LeftHandEntry() throws {
        //Input 1 negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        
        calculatorEngine.negatePressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-1)))
    }
    
    func testMedium_LeftHandEntry() throws {
        //Input 1 2 3 negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-123)))
    }
    
    func testLarge_LeftHandEntry() throws {
        //Input 1 2 3 4 5 6 7 8 9 negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(9)
        
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.formatted() == Decimal(-123456789).formatted())
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-123456789)))
    }
    
    // MARK: - Continuously Pressing Equals Negate
    
    func testLeftHandEntryTwice() throws {
        //Input 1 negate negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
    }
    
    func testLargeLeftHandEntryTwice() throws {
        //Input 100 negate negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(100)))
    }
    
    func testLeftHandEntryThrice() throws {
        //Input 1 negate negate negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-1)))
    }
    
    // MARK: - operands - Right
    
    func testSmall_RightHandEntry() throws {
        //Input 1 + 1 negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        
        calculatorEngine.negatePressed()
        
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(-1)) ?? false)
    }
    
    func testMedium_RightHandEntry() throws {
        //Input 1 - 3 2 1 negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(1)
        
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(-321)) ?? false)
    }
    
    func testLarge_RightHandEntry() throws {
        //Input 1 / 1 2 3 4 5 6 7 8  9 negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(9)
        
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(-123456789)) ?? false)
    }
    
    // MARK: - Pressing Button Multiple Times - Right
    
    func testRightHandEntryTwice() throws {
        //Input 1 + 1 negate negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(1)) ?? false)
    }
    
    func testLargeRightHandEntryTwice() throws {
        //Input 1 + 1 0 0 negate negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(100)) ?? false)
    }
    
    func testRightHandEntryThrice() throws {
        //Input 1 + 1 negate negate negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(-1)) ?? false)
    }
    
    // MARK: - Result
    
    func testNegatingAResult() throws {
        //Input 1 + 1 = negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.negatePressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: -2))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation  == nil)
    }
    
    func testNegatingAResultTwice() throws {
        //Input 1 + 1 = negate negate negate negate
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.negatePressed()
        calculatorEngine.negatePressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: 2))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation  == nil)
    }
    
    //MARK: - Negate Decimals - Left
    
    func testDecimals_LeftHandEntry() throws {
        //Input 0 . 1 2 3 4 5 6 7 8 9 negate
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
        
        calculatorEngine.negatePressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.formatted() == Decimal(-0.123456789).formatted())
    }
    
    //MARK: - Negate Decimals - Right
    
    func testDecimals_RightHandEntry() throws {
        //Input 0 + 0 . 1 2 3 4 5 6 7 8 9 negate
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
        
        calculatorEngine.negatePressed()
        
        XCTAssertTrue(calculatorEngine.rightHandOperand?.formatted() ?? "" == Decimal(-0.123456789).formatted())
    }
}
