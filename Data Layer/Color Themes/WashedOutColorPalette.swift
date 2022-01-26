//
//  WashedOutColorPalette.swift
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

struct WashedOutColorPalette: ColorPalette {
    var background: String = "#ECF5FF"
        
    var display: String = "#0D2A4B"
    
    var operatorNormal: String = "#A3CFF9"
    
    var operatorSelected: String = "#0D2A4B"
    
    var operatorTitle: String = "#5487BA"
    
    var operatorTitleSelected: String = "#ffffff"
    
    var pinPad: String = "#1D1D1D"
    
    var pinPadTitle: String = "#ffffff"
    
    var extraFunctions: String = "#A3CFF9"
    
    var extraFunctionsTitle: String = "#5487BA"
    
    var statusBarStyle: StatusBarStyle = .dark
}

