//
//  DarkBlueCalculatorTheme.swift
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

struct DarkBlueTheme: CalculatorTheme {
    var background: String = "#1D1D1D"
        
    var display: String = "#727272"
    
    var operatorNormal: String = "#4566B6"
    
    var operatorSelected: String = "#4566B6"
    
    var operatorTitle: String = "#ffffff"
    
    var operatorTitleSelected: String = "#ffffff"
    
    var pinPad: String = "#1D1D1D"
    
    var pinPadTitle: String = "#767676"
    
    var extraFunctions: String = "#323232"
    
    var extraFunctionsTitle: String = "#FFFFFF"
    
    var statusBarStyle: StatusBarStyle = .light
}
