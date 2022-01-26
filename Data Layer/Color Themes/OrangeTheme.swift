//
//  OrangeCalculatorTheme.swift
//  Calc
//
//  Created by Matthew Paul Harding on 26/01/2022.
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

struct OrangeTheme: CalculatorTheme {
    
    var background: String = "#DC6969"
        
    var display: String = "#ffffff"
    
    var operatorNormal: String = "#CC4D4D"
    
    var operatorSelected: String = "#AB2F2F"
    
    var operatorTitle: String = "#ffffff"
    
    var operatorTitleSelected: String = "#ffffff"
    
    var pinPad: String = "#C94848"
    
    var pinPadTitle: String = "#ffffff"
    
    var extraFunctions: String = "#D05353"
    
    var extraFunctionsTitle: String = "#ffffff"
    
    var statusBarStyle: StatusBarStyle = .light
}

