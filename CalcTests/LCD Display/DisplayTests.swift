//
//  DisplayTests.swift
//  CalcTests
//
//  Created by iOSB Free on 27/01/2022.
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
//   It's our testing team! They are testing pressing the display panel (LCD Display).
//   Architecural Layer: Testing Layer
//
//   💡 Career Tip 👉🏻 Writing unit tests prevents your work being rejected by the testing
//   department, which means we can become a dependable member of our team.
// *******************************************************************************************


import XCTest
@testable import Calc

class DisplayTests: XCTestCase {

    // MARK: - NaN
    
    func testNan() throws {
        //Input 0 7 0 =
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
        //Input .
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.decimalPressed()
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0.")
    }

    func testDecimal2() throws {
        //Input 0 .
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.decimalPressed()
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0.")
    }
    
    // MARK: - Numbers - Left
    
    func testZero() throws {
        //Input 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func testOne() throws {
        //Input 1
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "1")
    }
    
    func testTwo() throws {
        //Input 2
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(2)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "2")
    }
    
    func testThree() throws {
        //Input 3
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(3)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "3")
    }
    
    func testFour() throws {
        //Input 4
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "4")
    }
    
    func testFive() throws {
        //Input 5
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(5)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "5")
    }
    
    func testSix() throws {
        //Input 6
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(6)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "6")
    }
    
    func testSeven() throws {
        //Input 7
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(7)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "7")
    }
    
    func testEiight() throws {
        //Input 8
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(8)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "8")
    }
    
    func testNine() throws {
        //Input 9
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(9)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "9")
    }
    
    // MARK: - Numbers - Right
    
    func testZero_RightHandSide() throws {
        //Input 1 + 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func testOne_RightHandSide() throws {
        //Input 0 + 1
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "1")
    }
    
    func testTwo_RightHandSide() throws {
        //Input 0 + 2
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(2)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "2")
    }
    
    func testThree_RightHandSide() throws {
        //Input 0 + 3
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "3")
    }
    
    func testFour_RightHandSide() throws {
        //Input 0 + 4
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(4)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "4")
    }
    
    func testFive_RightHandSide() throws {
        //Input 0 + 5
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(5)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "5")
    }
    
    func testSix_RightHandSide() throws {
        //Input 0 + 6
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(6)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "6")
    }
    
    func testSeven_RightHandSide() throws {
        //Input 0 + 7
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(7)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "7")
    }
    
    func testEiight_RightHandSide() throws {
        //Input 0 + 8
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(8)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "8")
    }
    
    func testNine_RightHandSide() throws {
        //Input 0 + 9
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(9)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "9")
    }
    
    // MARK: - Consecutive Numbers - Left
    
    func testConsecutiveZero_LeftHandSide() throws {
        //Input 0 0 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func testConsecutiveOne_LeftHandSide() throws {
        //Input 1 1 1
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "111")
    }
    
    func testConsecutiveTwo_LeftHandSide() throws {
        //Input 2 2 2
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(2)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "222")
    }
    
    func testConsecutiveThree_LeftHandSide() throws {
        //Input 3 3 3
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "333")
    }
    
    func testConsecutiveFour_LeftHandSide() throws {
        //Input 4 4 4
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(4)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "444")
    }
    
    func testConsecutiveFive_LeftHandSide() throws {
        //Input 5 5 5
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "555")
    }
    
    func testConsecutiveSix_LeftHandSide() throws {
        //Input 6 6 6
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(6)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "666")
    }
    
    func testConsecutiveSeven_LeftHandSide() throws {
        //Input 7 7 7
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(7)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "777")
    }
    
    func testConsecutiveEiight_LeftHandSide() throws {
        //Input 8 8 8
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(8)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "888")
    }
    
    func testConsecutiveNine_LeftHandSide() throws {
        //Input 9 9 9
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "999")
    }
    
    // MARK: - Consecutive Numbers - Right
    
    func testConsecutiveZero_RightHandSide() throws {
        //Input 1 + 0 0 0
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "0")
    }
    
    func testConsecutiveOne_RightHandSide() throws {
        //Input 0 + 1 1 1
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(1)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "111")
    }
    
    func testConsecutiveTwo_RightHandSide() throws {
        //Input 0 + 2 2 2
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(2)
        calculatorEngine.numberPressed(2)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "222")
    }
    
    func testConsecutiveThree_RightHandSide() throws {
        //Input 0 + 3 3 3
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        calculatorEngine.numberPressed(3)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "333")
    }
    
    func testConsecutiveFour_RightHandSide() throws {
        //Input 0 + 4 4 4
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(4)
        calculatorEngine.numberPressed(4)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "444")
    }
    
    func testConsecutiveFive_RightHandSide() throws {
        //Input 0 + 5 5 5
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(5)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "555")
    }
    
    func testConsecutiveSix_RightHandSide() throws {
        //Input 0 + 6 6 6
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(6)
        calculatorEngine.numberPressed(6)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "666")
    }
    
    func testConsecutiveSeven_RightHandSide() throws {
        //Input 0 + 7 7 7
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(7)
        calculatorEngine.numberPressed(7)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "777")
    }
    
    func testConsecutiveEiight_RightHandSide() throws {
        //Input 0 + 8 8 8
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(8)
        calculatorEngine.numberPressed(8)
        
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "888")
    }
    
    func testConsecutiveNine_RightHandSide() throws {
        //Input 0 + 9 9 9
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
        //Input 5 5 5 + 5 5 5 =
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
        //Input 5 5 5 5 5 5 + 5 5 5 5 5 5 =
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
    
    // MARK: - Scientific Calculator
    
    func testScientificCalculator() throws {
        //Input 1 0 0 0 0 0 0 0 0 0 0 0 0 + 1 0 0 0 0 0 0 0 0 0 0 0 0 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.resultOfEquation?.formatted() == "2,000,000,000,000")
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "2e12")
    }
    
    func testLowerLimits_ScientificCalculator() throws {
        //Input 1 0 0 0 0 0 0 0 0 + 1 0 0 0 0 0 0 0 0 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.resultOfEquation?.formatted() == "200,000,000")
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "200,000,000")
    }
    
    func testUpperLimits_ScientificCalculator() throws {
        //Input 9 9 9 9 9 9 9 9 8 + 1 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(9)
        calculatorEngine.numberPressed(8)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(1)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.resultOfEquation?.formatted() == "999,999,999")
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "999,999,999")
    }
    
    func testThreshold_ScientificCalculator() throws {
        //Input 5 0 0 0 0 0 0 0 0 + 5 0 0 0 0 0 0 0 0 =
        var calculatorEngine = iOSBFreeCalculatorEngine()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.addPressed()
        calculatorEngine.numberPressed(5)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.numberPressed(0)
        calculatorEngine.equalsPressed()
        
        XCTAssertTrue(calculatorEngine.resultOfEquation?.formatted() == "1,000,000,000")
        XCTAssertTrue(calculatorEngine.lcdDisplayText == "1e9")
    }
}
