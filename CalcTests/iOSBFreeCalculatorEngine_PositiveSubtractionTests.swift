//
//  iOSBFreeCalculatorEngine_PositiveSubtractionTests.swift
//  CalcTests
//
//  Created by Matthew Paul Harding on 25/01/2022.
//

import XCTest
@testable import Calc

class iOSBFreeCalculatorEngine_PositiveSubtractionTests: XCTestCase {

    func testPositiveSubtraction() throws {
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
    
    func testPositiveSubtraction_6(_ number: Int, calculatorEngine: iOSBFreeCalculatorEngine) throws {
        subtract(1)
        subtract(2)
        subtract(3)
        subtract(4)
        subtract(5)
        subtract(6)
        subtract(7)
        subtract(8)
        subtract(9)
        subtract(10)
    }
    
    private func subtract(_ number: Int) {
        
        // setup
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(number)))
        XCTAssertTrue(result.isEqual(to: Decimal(0)))
        
        // loop forward
        for iteration in 1...10 {
            calculatorEngine.minusPressed()
            calculatorEngine.numberPressed(number)
            calculatorEngine.equalsPressed()
            
            guard let result2 = calculatorEngine.resultOfEquation else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }
            
            guard let rhd2 = calculatorEngine.rightHandOperand else {
                XCTAssert(true, "Did not have right hand value")
                return
            }
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: result))
            XCTAssertTrue(rhd2.isEqual(to: Decimal(number)))
            XCTAssertTrue(result2.isEqual(to: Decimal(-number * iteration)))
        }
        
    }
    
    func testContinuedPositiveSubtraction() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(1)))
        XCTAssertTrue(result.isEqual(to: Decimal(-1)))
    }
    
    func testContinuedPositiveSubtraction_3() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(1)))
        XCTAssertTrue(result.isEqual(to: Decimal(-1)))
        
        
        // add another value to the result
        calculatorEngine.minusPressed()
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-1)))
        XCTAssertTrue(rhd2.isEqual(to: Decimal(1)))
        XCTAssertTrue(result2.isEqual(to: Decimal(-2)))
    }
    
    func testContinuedPositiveSubtraction_4() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(rhd.isEqual(to: Decimal(1)))
        XCTAssertTrue(result.isEqual(to: Decimal(-1)))
        
        // add another value to the result
        calculatorEngine.minusPressed()
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-1)))
        XCTAssertTrue(rhd2.isEqual(to: Decimal(1)))
        XCTAssertTrue(result2.isEqual(to: Decimal(-2)))
        
        // add another value to the result
        calculatorEngine.minusPressed()
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-2)))
        XCTAssertTrue(rhd3.isEqual(to: Decimal(1)))
        XCTAssertTrue(result3.isEqual(to: Decimal(-3)))
    }
    
    func testContinuedPositiveSubtraction_2() throws {
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
        
        // add another value to the result
        calculatorEngine.minusPressed()
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

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(rhd2.isEqual(to: Decimal(1)))
        XCTAssertTrue(result2.isEqual(to: Decimal(-1)))
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        // add another value to the result
        calculatorEngine.minusPressed()
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-5)))
        XCTAssertTrue(rhdFinal.isEqual(to: Decimal(1)))
        XCTAssertTrue(resultFinal.isEqual(to: Decimal(-6)))
    }

    func testContinuedPositiveSubtraction_5() throws {
        
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
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-171)))
        XCTAssertTrue(rhdFinal.isEqual(to: Decimal(2)))
        XCTAssertTrue(resultFinal.isEqual(to: Decimal(-174)))
    }
}
