//
//  LightCalculatorTheme.swift
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

struct LightTheme: CalculatorTheme {
    var background: String = "#F6F8F9"
        
    var display: String = "#000000"
    
    var operatorNormal: String = "#4BE6A9"
    
    var operatorSelected: String = "#70729D"
    
    var operatorTitle: String = "#14145C"
    
    var operatorTitleSelected: String = "#ffffff"
    
    var pinPad: String = "#E9F0F4"
    
    var pinPadTitle: String = "#000000"
    
    var extraFunctions: String = "#E9F0F4"
    
    var extraFunctionsTitle: String = "#4BE6A9"
    
    var statusBarStyle: StatusBarStyle = .dark
}
