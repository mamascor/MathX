//
//  DisplayTests.swift
//  CalcTests
//
//  Created by Matthew Paul Harding on 27/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💚 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's a Calculator Theme, used to display a different color theme
//   💡 Team Tip 👉🏻 You could provide these files to a designer, if you wanted to.
// *******************************************************************************************


import XCTest
@testable import Calc

class DisplayTests: XCTestCase {

    // MARK: - NaN
    
    func testNan() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.dividePressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.leftHandOperand.isEqual(to: Decimal(0)))
        XCTAssertTrue(calculatorEngine.rightHandOperand?.isEqual(to: Decimal(0)) ?? false)
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal.nan) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "Error")
    }
    
    // MARK: - Decimal
    
    func testDecimal() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.decimalPressed()
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0.")
    }

    func testDecimal2() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0.")
    }
    
    // MARK: - Numbers - Left
    
    func testZero() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func testOne() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "1")
    }
    
    func testTwo() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(2)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "2")
    }
    
    func testThree() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(3)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "3")
    }
    
    func testFour() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "4")
    }
    
    func testFive() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(5)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "5")
    }
    
    func testSix() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(6)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "6")
    }
    
    func testSeven() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(7)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "7")
    }
    
    func testEiight() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(8)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "8")
    }
    
    func testNine() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(9)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "9")
    }
    
    // MARK: - Numbers - Right
    
    func testZero_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func testOne_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "1")
    }
    
    func testTwo_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(2)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "2")
    }
    
    func testThree_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "3")
    }
    
    func testFour_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(4)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "4")
    }
    
    func testFive_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(5)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "5")
    }
    
    func testSix_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(6)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "6")
    }
    
    func testSeven_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(7)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "7")
    }
    
    func testEiight_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(8)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "8")
    }
    
    func testNine_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(9)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "9")
    }
    
    // MARK: - Consecutive Numbers - Left
    
    func testConsecutiveZero_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func testConsecutiveOne_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "111")
    }
    
    func testConsecutiveTwo_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(2)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "222")
    }
    
    func testConsecutiveThree_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "333")
    }
    
    func testConsecutiveFour_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(4)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "444")
    }
    
    func testConsecutiveFive_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "555")
    }
    
    func testConsecutiveSix_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(6)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "666")
    }
    
    func testConsecutiveSeven_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(7)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "777")
    }
    
    func testConsecutiveEiight_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(8)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "888")
    }
    
    func testConsecutiveNine_LeftHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "999")
    }
    
    // MARK: - Consecutive Numbers - Right
    
    func testConsecutiveZero_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func testConsecutiveOne_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "111")
    }
    
    func testConsecutiveTwo_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(2)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "222")
    }
    
    func testConsecutiveThree_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "333")
    }
    
    func testConsecutiveFour_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(4)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "444")
    }
    
    func testConsecutiveFive_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "555")
    }
    
    func testConsecutiveSix_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(6)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "666")
    }
    
    func testConsecutiveSeven_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(7)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "777")
    }
    
    func testConsecutiveEiight_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(8)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "888")
    }
    
    func testConsecutiveNine_RightHandSide() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "999")
    }
    
    // MARK: - Result
    
    func testThousandResult() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(1110)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "1,110")
    }
    
    func testMillionResult() throws {
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.resultOfEquation?.isEqual(to: Decimal(1111110)) ?? false)
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "1,111,110")
    }
}
