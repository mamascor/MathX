//
//  UIButton+Decorate.swift
//  Calc
//
//  Created by iOSB Free on 01/01/22.
//  Copyright © 2022 iOSB Free Ltd. All rights reserved.
//
//
//  iOSB Free Ltd                   → All rights reserved
//  Website                         → https://www.iosbfree.com
//
//  👉🏻 Free Courses                 → https://www.udemy.com/user/iosbfree
//
//  YouTube                         → https://www.youtube.com/channel/UCWBUOVRbtKNml4jN_4bRkCQ
//  Linked In                       → http://www.linkedin.com/in/mattharding-iosbfree
//
//  Tell us what
//  you want to learn
//
//  💜 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's an extension. It adds more features to UIButton, such as making a button circular.
//   Architecural Layer: Presentation Layer
//
//   💡 Tip 👉🏻 We can simplify our work by using extensions and making life a little easier.
// *******************************************************************************************


import UIKit

extension UIButton {
    
    func becomeRound() {
        clipsToBounds = true
        layer.cornerRadius = bounds.height / 2
    }

}
