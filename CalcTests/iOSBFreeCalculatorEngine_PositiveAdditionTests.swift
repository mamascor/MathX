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
    
    func testContinuedPositiveAddition() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(2)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(1)))
        XCTAssertTrue(result.isEqual(to: Decimal(3)))
    }
    
    func testContinuedPositiveAddition_3() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(2)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(1)))
        XCTAssertTrue(result.isEqual(to: Decimal(3)))
        
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let result2 = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd2 = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(3)))
        XCTAssertTrue(rhd2.isEqual(to: Decimal(1)))
        XCTAssertTrue(result2.isEqual(to: Decimal(4)))
    }
    
    func testContinuedPositiveAddition_4() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(2)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(1)))
        XCTAssertTrue(result.isEqual(to: Decimal(3)))
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let result2 = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd2 = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(3)))
        XCTAssertTrue(rhd2.isEqual(to: Decimal(1)))
        XCTAssertTrue(result2.isEqual(to: Decimal(4)))
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let result3 = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhd3 = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(4)))
        XCTAssertTrue(rhd3.isEqual(to: Decimal(1)))
        XCTAssertTrue(result3.isEqual(to: Decimal(5)))
    }
    
    func testContinuedPositiveAddition_2() throws {
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
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let result2 = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }

        guard let rhd2 = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(2)))
        XCTAssertTrue(rhd2.isEqual(to: Decimal(1)))
        XCTAssertTrue(result2.isEqual(to: Decimal(3)))
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        guard let resultFinal = calculatorEngine.resultOfEquation else {
            XCTAssert(true, "Did not have result after equation was expected to have completed")
            return
        }
        
        guard let rhdFinal = calculatorEngine.rightHandOperand else {
            XCTAssert(true, "Did not have right hand value")
            return
        }
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(7)))
        XCTAssertTrue(rhdFinal.isEqual(to: Decimal(1)))
        XCTAssertTrue(resultFinal.isEqual(to: Decimal(8)))
    }

    func testContinuedPositiveAddition_5() throws {
        
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
