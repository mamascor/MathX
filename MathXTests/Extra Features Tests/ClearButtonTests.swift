//
//  ClearButtonTests.swift
//  MathX



import XCTest
@testable import Calc

class ClearButtonTests: XCTestCase {

    // MARK: - Result
    
    func testClear() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.clearPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation == nil)
    }
    
    func testClearAfterPercentage() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.percentagePressed()
        
        calculatorEngine.clearPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation == nil)
    }
    
    func testClearAfterNegate() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.negatePressed()

        calculatorEngine.clearPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation == nil)
    }
    
    func testMultipleClear() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.clearPressed()
        calculatorEngine.clearPressed()
        calculatorEngine.clearPressed()
        calculatorEngine.clearPressed()
        calculatorEngine.clearPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand == nil)
        XCTAssertTrue(calculatorEngine.resultOfEquation == nil)
    }
}
