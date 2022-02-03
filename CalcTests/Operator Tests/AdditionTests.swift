//
//  AdditionTests.swift
//  CalcTests
//
//  Created by iOSB Free on 25/01/2022.
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
//  ❤️ iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's our testing team! They are testing pressing the add button.
//   Architecural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests prevents your work being rejected by the testing
//   department, which means we can become a dependable member of our team.
// *******************************************************************************************


import XCTest
@testable import Calc

class AdditionTests: XCTestCase {

    // MARK: - Basic
    
    func testBasicMath() throws {
        //Input 1 + 1 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(2)) ?? false)
    }
    
    // MARK: - Continuously Start New Equations
    
    func testPinpad() throws {
        // → 10 options on the pin pad
        continuouslyStartNewEquations(using: 1)
        continuouslyStartNewEquations(using: 2)
        continuouslyStartNewEquations(using: 3)
        continuouslyStartNewEquations(using: 4)
        continuouslyStartNewEquations(using: 5)
        continuouslyStartNewEquations(using: 6)
        continuouslyStartNewEquations(using: 7)
        continuouslyStartNewEquations(using: 8)
        continuouslyStartNewEquations(using: 9)
        continuouslyStartNewEquations(using: 0)
    }
    
    private func continuouslyStartNewEquations(using number: Int) {
        //Input 1 + number = number + number(2..11) =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(number)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(number)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(number + 1)) ?? false)
        
        // → Loop through more tests
        for iteration in 1...10 {
            calculatorEngine.numberPressed(number)
            calculatorEngine.addPressed()
            calculatorEngine.numberPressed(iteration + 1)
            calculatorEngine.equalsPressed()
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
            XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(iteration + 1)) ?? false)
            XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(number + (iteration + 1))) ?? false)
        }
        
    }
    
    // MARK: - Continuously Add From Result
    
    func testPinpad_ContinuouslyAdding() throws {
        // → 10 options on the pin pad
        continuouslyAdd(using: 1)
        continuouslyAdd(using: 2)
        continuouslyAdd(using: 3)
        continuouslyAdd(using: 4)
        continuouslyAdd(using: 5)
        continuouslyAdd(using: 6)
        continuouslyAdd(using: 7)
        continuouslyAdd(using: 8)
        continuouslyAdd(using: 9)
        continuouslyAdd(using: 0)
    }
    
    private func continuouslyAdd(using number: Int) {
        //Input number + number = + 1..10 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(number)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(number)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(number * 2)) ?? false)
        
        // → Loop through more tests
        var currentResult: Decimal = Decimal(number + number)
        for iteration in 1...10 {
            calculatorEngine.addPressed()
            calculatorEngine.numberPressed(number)
            calculatorEngine.equalsPressed()
            
            guard let result = calculatorEngine.resultOfEquation else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: currentResult))
            XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(number)) ?? false)
            XCTAssertTrue(result.isEqual(to: Decimal(number * (iteration + 2))))
            
            currentResult = result
        }
    }
    
    // MARK: - Random Equation
    
    func testRandomEquation() throws {
        
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(7)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(127)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(7)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(127)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(134)) ?? false)
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(34)
        calculatorEngine.equalsPressed()

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(134)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(34)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(168)) ?? false)
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(6)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(5)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(2)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(186)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(2)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(188)) ?? false)
    }
}
