//
//  SubtractionTests.swift
//  MathX


import XCTest
@testable import Calc


class SubtractionTests: XCTestCase {

    // MARK: - Basic
    
    func testBasicMath() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(0)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    // MARK: - Continuously Start New Equations
    
    func testPinpad() throws {
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
        var calculatorEngine = iOSBFreeCalculatorEngine()
        
        for iteration in 0...9 {
            calculatorEngine.numberPressed(number)
            calculatorEngine.minusPressed()
            calculatorEngine.numberPressed(iteration)
            calculatorEngine.equalsPressed()
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
            XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(iteration)) ?? false)
            XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(number - iteration)) ?? false)
        }
    }
    
    // MARK: - Continuously Subtract From Result
    
    func testPinpad_ContinuouslySubtracting() throws {
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
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
        
        var currentResult = Decimal(number)
        for iteration in 0...9 {
            calculatorEngine.minusPressed()
            calculatorEngine.numberPressed(iteration)
            calculatorEngine.equalsPressed()
            
            guard let result = calculatorEngine.resultOfEquation else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: currentResult))
            XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(iteration)) ?? false)
            XCTAssertTrue(result.isEqual(to: currentResult - Decimal(iteration)))
            
            currentResult = result
        }
    }

    // MARK: - Random Equation
    
    func testRandomEquation() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(7)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(7)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(6)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(5)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(2)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-172)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(2)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(-174)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "-174")
    }
}
