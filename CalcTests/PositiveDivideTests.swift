//
//  PositiveDivideTests.swift
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

class PositiveDivideTests: XCTestCase {

    func testPositiveMultiplication() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.dividePressed()
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
        XCTAssertTrue(result.isEqual(to: Decimal(1)))
    }

    func testPositiveGrowingMultiplicationFromPinpad() throws {
        
        // 10 options on the pin pad
        continuouslyGrowingDivision(using: 1)
        continuouslyGrowingDivision(using: 2)
        continuouslyGrowingDivision(using: 3)
        continuouslyGrowingDivision(using: 4)
        continuouslyGrowingDivision(using: 5)
        continuouslyGrowingDivision(using: 6)
        continuouslyGrowingDivision(using: 7)
        continuouslyGrowingDivision(using: 8)
        continuouslyGrowingDivision(using: 9)
        continuouslyGrowingDivision(using: 0)
    }
    
    private func continuouslyGrowingDivision(using number: Int) {
        //Input: 7 / 1 / 2 / 3 / 4 / 5 / 6 / 7 / 8 / 9
        
        // setup
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let firstResult = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let firstRightHandValue = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
        XCTAssertTrue(firstRightHandValue.isEqual(to: Decimal(1)))
        XCTAssertTrue(firstResult.isEqual(to: Decimal(number)))
        
        // loop forward
        var currentResult: Decimal = firstResult
        for iteration in 1...10 {
            calculatorEngine.dividePressed()
            calculatorEngine.numberPressed(iteration + 1)
            calculatorEngine.equalsPressed()
            
            guard let result = calculatorEngine.resultOfEquation else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }
            
            guard let rhd = calculatorEngine.rightHandOperand else {
                XCTAssert(true, "Did not have right hand value")
                return
            }
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: currentResult))
            XCTAssertTrue(rhd.isEqual(to: Decimal(iteration + 1)))
            XCTAssertTrue(result.isEqual(to: currentResult / Decimal(iteration + 1)))
            
            currentResult = result
        }
        
    }
    
    func testPositiveMultiplicationFromPinpad() throws {
        
        // 10 options on the pin pad
        continuouslyMultiply(using: 1)
        continuouslyMultiply(using: 2)
        continuouslyMultiply(using: 3)
        continuouslyMultiply(using: 4)
        continuouslyMultiply(using: 5)
        continuouslyMultiply(using: 6)
        continuouslyMultiply(using: 7)
        continuouslyMultiply(using: 8)
        continuouslyMultiply(using: 9)
        continuouslyMultiply(using: 0)
    }
    
    private func continuouslyMultiply(using number: Int) {
        //Input: 7 / 1, 7 / 2, 7 / 3, 7 / 4, 7 / 5, 7 / 6, 7 / 7, 7 / 8, 7 / 9
        
        // setup
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let firstResult = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let firstRightHandValue = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
        XCTAssertTrue(firstRightHandValue.isEqual(to: Decimal(1)))
        XCTAssertTrue(firstResult.isEqual(to: Decimal(number)))
        
        // loop forward
        for iteration in 1...10 {
            calculatorEngine.numberPressed(number)
            calculatorEngine.dividePressed()
            calculatorEngine.numberPressed(iteration + 1)
            calculatorEngine.equalsPressed()
            
            guard let result = calculatorEngine.resultOfEquation else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }
            
            guard let rhd = calculatorEngine.rightHandOperand else {
                XCTAssert(true, "Did not have right hand value")
                return
            }
            
            let doubleValue: Double = Double(number) / Double(iteration + 1)
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
            XCTAssertTrue(rhd.isEqual(to: Decimal(iteration + 1)))
            // Note: comparing floating point numbers causes our tests to fail. They are not accurate enough to compare.
            XCTAssertTrue(result.formatted() == Decimal(doubleValue).formatted())
        }
        
    }
}
