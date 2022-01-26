//
//  PercentageButtonTests.swift
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

class PercentageButtonTests: XCTestCase {

    // MARK: - operands - Left
    
    func testSmallLeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.01)))
    }
    
    func testLargeLeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(100)
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
    }
    
    func testLargeLeftHandEntry2() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(200)
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(2)))
    }

    func testLeftHandEntryTwice() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.0001)))
    }
    
    func testLeftHandEntryThrice() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.000001)))
    }
    
    // MARK: - operands - Right
    
    func testSmallRightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.01)) ?? false)
    }
    
    func testLargeRightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(100)
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(1)) ?? false)
    }
    
    func testLargeRightHandEntry2() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(200)
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(2)) ?? false)
    }

    func testRightHandEntryTwice() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.0001)) ?? false)
    }
    
    func testRightHandEntryThrice() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0.000001)) ?? false)
    }
    
    // MARK: - Result
    
    func testNegatingAResult() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(300)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(300)
        calculatorEngine.equalsPressed()
        
        guard let result1 = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd1 = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(300)))
        XCTAssertTrue(rhd1.isEqual(to: Decimal(300)))
        XCTAssertTrue(result1.isEqual(to: Decimal(600)))
        
        calculatorEngine.percentagePressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: 6))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation  == nil)
    }
    
    func testNegatingAResultTwice() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(300)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(300)
        calculatorEngine.equalsPressed()
   
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: 0.06))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation  == nil)
    }
    
    func testNegatingAResultThrice() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(300)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(300)
        calculatorEngine.equalsPressed()
   
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()
        calculatorEngine.percentagePressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.formatted() == Decimal(0.0006).formatted())
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation  == nil)
    }
}
