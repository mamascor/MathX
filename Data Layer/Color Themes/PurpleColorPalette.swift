//
//  PurpleColorPalette.swift
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

struct PurpleColorPalette: ColorPalette {
    var background: String = "#F4F5FA"
        
    var display: String = "#1D1D1D"
    
    var operatorNormal: String = "#7550FE"
    
    var operatorSelected: String = "#4566B6"
    
    var operatorTitle: String = "#ffffff"
    
    var operatorTitleSelected: String = "#ffffff"
    
    var pinPad: String = "#1D1D1D"
    
    var pinPadTitle: String = "#ffffff"
    
    var extraFunctions: String = "#F4F5FA"
    
    var extraFunctionsTitle: String = "#7550FE"
    
    var statusBarStyle: StatusBarStyle = .dark
}

