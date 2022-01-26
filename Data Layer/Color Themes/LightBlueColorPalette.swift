//
//  LightBlueColorPalette.swift
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

struct LightBlueColorPalette: ColorPalette {
    var background: String = "#F8F8F8"
        
    var display: String = "#000000"
    
    var operatorNormal: String = "#00B4FF"
    
    var operatorSelected: String = "#0265FF"
    
    var operatorTitle: String = "#ffffff"
    
    var operatorTitleSelected: String = "#ffffff"
    
    var pinPad: String = "#EEEEEE"
    
    var pinPadTitle: String = "#000000"
    
    var extraFunctions: String = "#D6DEE5"
    
    var extraFunctionsTitle: String = "#00B4FF"
    
    var statusBarStyle: StatusBarStyle = .dark
}
