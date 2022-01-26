//
//  iOSBFreeCalculatorEngine_PositiveAdditionTests.swift
//  CalcTests
//
//  Created by Matthew Paul Harding on 25/01/2022.
//

import XCTest
@testable import Calc

class iOSBFreeCalculatorEngine_PositiveAdditionTests: XCTestCase {

    func testPositiveAddition() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
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
        XCTAssertTrue(result.isEqual(to: Decimal(2)))
        
    }
    
    func testPositiveSubtractionFromPinpad() throws {
        
        // 10 options on the pin pad
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
        
        // setup
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
        calculatorEngine.addPressed()
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
        XCTAssertTrue(firstResult.isEqual(to: Decimal(number * 2)))
        
        // loop forward
        var currentResult: Decimal = firstResult
        for iteration in 1...10 {
            calculatorEngine.addPressed()
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
            XCTAssertTrue(result.isEqual(to: Decimal(number * (iteration + 2))))
            
            currentResult = result
        }
        
    }
  
    func testContinuedPositiveAddition__RandomNumbers() throws {
        
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(7)
        calculatorEngine.addPressed()
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
        XCTAssertTrue(result.isEqual(to: Decimal(134)))
        
        // add another value to the result
        calculatorEngine.addPressed()
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

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(134)))
        XCTAssertTrue(rhd2.isEqual(to: Decimal(34)))
        XCTAssertTrue(result2.isEqual(to: Decimal(168)))
        
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
        
        guard let resultFinal = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhdFinal = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(186)))
        XCTAssertTrue(rhdFinal.isEqual(to: Decimal(2)))
        XCTAssertTrue(resultFinal.isEqual(to: Decimal(188)))
    }
}
