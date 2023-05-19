//
//  PinPadTests.swift
//  MathX



import XCTest
@testable import Calc

class PinPadTests: XCTestCase {

    // MARK: - Operands - Left
    
    func testSmall_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(1)))
    }
    
    func testMedium_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(123)))
    }
    
    func testLarge_LeftHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(9)

        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(123456789)))
    }
    
    
    
    // MARK: - Operands - Right
    
    func testSmall_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(1)) ?? false)
    }
    
    func testMedium_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.minusPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(1)

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(321)) ?? false)
    }
    
    func testLarge_RightHandEntry() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(9)

        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(123456789)) ?? false)
    }
}
