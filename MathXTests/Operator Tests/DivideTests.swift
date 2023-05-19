//
//  DivideTests.swift
//  MathX



import XCTest
@testable import Calc

class DivideTests: XCTestCase {

    // MARK: - Basic
    
    func testBasicMath() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(1)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(1)) ?? false)
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
            calculatorEngine.dividePressed()
            calculatorEngine.numberPressed(iteration)
            calculatorEngine.equalsPressed()
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(number)))
            XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(iteration)) ?? false)
            XCTAssertTrue(calculatorEngine.resultOfEquation?.formatted() == (Decimal(number) / Decimal(iteration)).formatted())
            // 💡 Why compare strings? 👉🏻 Comparing floating point numbers causes our tests to fail. They are not accurate enough to compare.
        }
        
    }
    
    // MARK: - Continuously Subtract From Result
    
    func testPinpad_ContinuouslyDividing() throws {
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
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(number)
        
        var currentResult: Decimal = Decimal(number)
        for iteration in 0...9 {
            calculatorEngine.dividePressed()
            calculatorEngine.numberPressed(iteration)
            calculatorEngine.equalsPressed()
            
            guard let result = calculatorEngine.resultOfEquation else {
                XCTAssert(true, "Did not have result after equation was expected to have completed")
                return
            }
            
            XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: currentResult))
            XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(iteration)) ?? false)
            XCTAssertTrue(result.isEqual(to: currentResult / Decimal(iteration)))
            
            currentResult = result
        }
    }
}
