//
//  EqualsButtonTests.swift
//  MathX



import XCTest
@testable import Calc

class EqualsButtonTests: XCTestCase {
    
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
    }
    
    // MARK: - Continuously Pressing Equals From Result
    
    func testEquals_UsingAddition() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.equalsPressed()
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(12)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(4)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(16)) ?? false)
    }
    
    func testEquals_UsingSubtraction() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()

        calculatorEngine.equalsPressed()
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(-4)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(4)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(-8)) ?? false)
    }
    
    func testEquals_UsingMultiplication() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.multiplyPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()

        calculatorEngine.equalsPressed()
        calculatorEngine.equalsPressed()
 
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(64)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(4)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(256)) ?? false)
    }
    
    func testEquals_UsingDivision() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.equalsPressed()
        
        calculatorEngine.equalsPressed()
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0.25)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(4)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.formatted() ==  Decimal(0.0625).formatted())
    }
}
