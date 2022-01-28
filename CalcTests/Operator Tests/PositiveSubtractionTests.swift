//
//  PositiveSubtractionTests.swift
//  CalcTests
//
//  Created by iOSB Free on 25/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏻 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💜 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's our testing team! They are testing pressing the minus button.
//   Architecural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests prevents your work being rejected by the testing
//   department, which means we can become a dependable member of our team.
// *******************************************************************************************


import XCTest
@testable import Calc

class PositiveSubtractionTests: XCTestCase {

    func testSubtraction() throws {
        //Input 1 - 1 =
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
    
    func testSubtractionUsingPinpad() throws {
        
        // → 10 options on the pin pad
        continuouslySubtract(using: 1)
        continuouslySubtract(using: 2)
        continuouslySubtract(using: 3)
        continuouslySubtract(using: 4)
        continuouslySubtract(using: 5)
        continuouslySubtract(using: 6)
        continuouslySubtract(using: 7)
        continuouslySubtract(using: 8)
        continuouslySubtract(using: 9)
        continuouslySubtract(using: 0)
    }
    
    private func continuouslySubtract(using number: Int) {
        //Input number - number = _ 1..10 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(number)
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
        XCTAssertTrue(firstRightHandValue.isEqual(to: Decimal(number)))
        XCTAssertTrue(firstResult.isEqual(to: Decimal(0)))
        
        // loop forward
        var currentResult: Decimal = firstResult
        for iteration in 0...9 {
            calculatorEngine.minusPressed()
            calculatorEngine.numberPressed(number)
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
            XCTAssertTrue(rhd.isEqual(to: Decimal(number)))
            XCTAssertTrue(result.isEqual(to: Decimal(-number * iteration)))
            
            currentResult = result
        }
    }

    func testMultiplicationFromPinpad() throws {
        // → 10 options on the pin pad
        testEnteringNewEquationAfterViewingAResult(using: 1)
        testEnteringNewEquationAfterViewingAResult(using: 2)
        testEnteringNewEquationAfterViewingAResult(using: 3)
        testEnteringNewEquationAfterViewingAResult(using: 4)
        testEnteringNewEquationAfterViewingAResult(using: 5)
        testEnteringNewEquationAfterViewingAResult(using: 6)
        testEnteringNewEquationAfterViewingAResult(using: 7)
        testEnteringNewEquationAfterViewingAResult(using: 8)
        testEnteringNewEquationAfterViewingAResult(using: 9)
        testEnteringNewEquationAfterViewingAResult(using: 0)
    }
    
    private func testEnteringNewEquationAfterViewingAResult (using number: Int) {
        //Input number - 1 = number - 1..10 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
        calculatorEngine.minusPressed()
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
        XCTAssertTrue(firstResult.isEqual(to: Decimal(number - 1)))
        
        // → Loop through more tests
        for iteration in 1...10 {
            calculatorEngine.numberPressed(number)
            calculatorEngine.minusPressed()
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
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
            XCTAssertTrue(rhd.isEqual(to: Decimal(iteration + 1)))
            XCTAssertTrue(result.isEqual(to: Decimal(number - (iteration + 1))))
        }
    }
    
    func testContinuedSubtraction_RandomNumbers() throws {
        //Input 7 - 127 = - 34 = - 6 = - 5 = - 4 = - 3 = - 2 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(7)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(127)
        calculatorEngine.equalsPressed()
        
        guard let result = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(7)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(127)))
        XCTAssertTrue(result.isEqual(to: Decimal(-120)))
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(34)
        calculatorEngine.equalsPressed()
        
        guard let result2 = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }

        guard let rhd2 = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-120)))
        XCTAssertTrue(rhd2.isEqual(to: Decimal(34)))
        XCTAssertTrue(result2.isEqual(to: Decimal(-154)))
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(6)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(5)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(2)
        calculatorEngine.equalsPressed()
        
        guard let resultFinal = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhdFinal = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-172)))
        XCTAssertTrue(rhdFinal.isEqual(to: Decimal(2)))
        XCTAssertTrue(resultFinal.isEqual(to: Decimal(-174)))
    }
}
