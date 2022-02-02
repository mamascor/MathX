//
//  DivideTests.swift
//  CalcTests
//
//  Created by iOSB Free on 26/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏾 Free Courses                 → https://www.udemy.com/user/iosbfree
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
//   It's our testing team! They are testing pressing the divide button.
//   Architecural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests prevents our work being rejected by the testing
//   department, which means we can become a dependable member of our team.
// *******************************************************************************************


import XCTest
@testable import Calc

class DivideTests: XCTestCase {

    func testDivision() throws {
        //Input 1 / 1 =
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

    func testGrowingDivisionFromPinpad() throws {
        
        // → 10 options on the pin pad
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
        //Input: number / 1 = / 2 = / 3 = / 4 = / 5 = / 6 = / 7 = / 8 = / 9 =  / 10 =
        
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
        
        // → Loop through more tests
        var currentResult: Decimal = firstResult
        for iteration in 0...9 {
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
    
    func testDivisionFromPinpad() throws {
        // → 10 options on the pin pad
        continuouslyDivide(using: 1)
        continuouslyDivide(using: 2)
        continuouslyDivide(using: 3)
        continuouslyDivide(using: 4)
        continuouslyDivide(using: 5)
        continuouslyDivide(using: 6)
        continuouslyDivide(using: 7)
        continuouslyDivide(using: 8)
        continuouslyDivide(using: 9)
        continuouslyDivide(using: 0)
    }
    
    private func continuouslyDivide(using number: Int) {
        //Input: number / 1 = number / 2 = number / 3 = number / 4 = number / 5 = number / 6 = number / 7 = number / 8 = number / 9 =  number / 10 =
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
        
        // → Loop through more tests
        for iteration in 0...9 {
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
