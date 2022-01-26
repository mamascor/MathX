//
//  CalculatorTheme.swift
//  Calc
//
//  Created by Matthew Paul Harding on 24/01/2022.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//  Tell us what you want to learn  → community@iosbfree.com
// *******************************************************************************************

import Foundation

enum StatusBarStyle {
    case light
    case dark
}

protocol CalculatorTheme {
    
    var background: String { get }
    var display: String { get }
    
    var operatorNormal: String { get }
    var operatorSelected: String { get }
    
    var operatorTitle: String { get }
    var operatorTitleSelected: String { get }
    
    var pinPad: String { get }
    var pinPadTitle: String { get }
    
    var extraFunctions: String { get }
    var extraFunctionsTitle: String { get }
    
    var statusBarStyle: StatusBarStyle { get }
}
