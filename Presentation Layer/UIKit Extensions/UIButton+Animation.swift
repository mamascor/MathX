//
//  UIButton+Animation.swift
//  Calc
//
//  Created by Matthew Paul Harding on 25/01/2022.
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
//  💙 iOSB Free
//  community@iosbfree.com
//  🧕🏻👨🏿‍💼👩🏼‍💼👩🏻‍💻👨🏼‍💼🧛🏻‍♀️👩🏼‍💻💁🏽‍♂️🕵🏻‍♂️🧝🏼‍♀️🦹🏼‍♀🧕🏾🧟‍♂️
// *******************************************************************************************
//
// → What's This File?
//   It's a Data Access Manager, a simple wrapper for User Defaults.
//   💡 Architecture Tip 👉🏻 Used to disconnect how we store the data from anywhere else.
// *******************************************************************************************

import UIKit

extension UIView {
    
    func bounce() {
        UIView.animate(withDuration: 0.1,
            animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 1
            },
            completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.transform = CGAffineTransform.identity
                }
            })
    }
    
}
