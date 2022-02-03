//
//  MultiplyTests.swift
//  CalcTests
//
//  Created by iOSB Free on 26/01/2022.
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏼 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//  Tell us what you want to learn  → community@iosbfree.com//
//  Tell us what
//  you want to learn
//
//  🤎 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's our testing team! They are testing pressing the multiply button.
//   Architecural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests prevents your work being rejected by the testing
//   department, which means we can become a dependable member of our team.
// *******************************************************************************************


import XCTest
@testable import Calc

class MultiplyTests: XCTestCase {
    
    // MARK: - Basic
    
    func testBasicMath() throws {
        //Input 1 * 1 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.multiplyPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
   
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(1)) ?? false)
    }
    
    func testGrowingMultiplicationUsingPinpad() throws {
        
        // → 10 options on the pin pad
        continuouslyGrowingMultiply(using: 1)
        continuouslyGrowingMultiply(using: 2)
        continuouslyGrowingMultiply(using: 3)
        continuouslyGrowingMultiply(using: 4)
        continuouslyGrowingMultiply(using: 5)
        continuouslyGrowingMultiply(using: 6)
        continuouslyGrowingMultiply(using: 7)
        continuouslyGrowingMultiply(using: 8)
        continuouslyGrowingMultiply(using: 9)
        continuouslyGrowingMultiply(using: 0)
    }
    
    private func continuouslyGrowingMultiply(using number: Int) {
        //Input: 1 * number = * 1..10 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.multiplyPressed()
        calculatorEngine.numberPressed(number)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(number)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(number)) ?? false)
        
        // → Loop through more tests
        var currentResult: Decimal = Decimal(number)
        for iteration in 1...10 {
            calculatorEngine.multiplyPressed()
            calculatorEngine.numberPressed(iteration + 1)
            calculatorEngine.equalsPressed()
            
            guard let result = calculatorEngine.resultOfEquation else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: currentResult))
            XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(iteration + 1)) ?? false)
            XCTAssertTrue(result.isEqual(to: currentResult * Decimal(iteration + 1)))
            
            currentResult = result
        }
        
    }
    
    func testMultiplicationFromPinpad() throws {
        // → 10 options on the pin pad
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
        //Input: 1 * number = 1..10 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.multiplyPressed()
        calculatorEngine.numberPressed(number)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(number)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(number)) ?? false)
        
        // → Loop through more tests
        for iteration in 0...9 {
            calculatorEngine.numberPressed(number)
            calculatorEngine.multiplyPressed()
            calculatorEngine.numberPressed(iteration + 1)
            calculatorEngine.equalsPressed()
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
            XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(iteration + 1)) ?? false)
            XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(number * (iteration + 1))) ?? false)
        }
    }
}
