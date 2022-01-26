//
//  DarkColorPalette.swift
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

struct DarkColorPalette: ColorPalette {
    var background: String = "#000000"
    
    var display: String = "#ffffff"
    
    var operatorNormal: String = "#ff9f0a"
    
    var operatorSelected: String = "#ffffff"
    
    var operatorTitle: String = "#ffffff"
    
    var operatorTitleSelected: String = "#ff9f0a"
    
    var pinPad: String = "#333333"
    
    var pinPadTitle: String = "#ffffff"
    
    var extraFunctions: String = "#a6a6a6"
    
    var extraFunctionsTitle: String = "#000000"
    
    var statusBarStyle: StatusBarStyle = .light
}
