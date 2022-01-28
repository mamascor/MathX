//
//  UIView+Animation.swift
//  Calc
//
//  Created by iOSB Free on 25/01/2022.
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
//   It's an extension. It adds more features to UIView, such as animation.
//   Architecural Layer: Presentation Layer
//
//   💡 Tip 👉🏻 Animations provide personality. They emotionally connect the product to the
//   audience and give the app a certain feel. Adding animations is a great idea.
// *******************************************************************************************


import UIKit

extension UIView {
    
    func bounce() {
        UIView.animate(withDuration: 0.1,
        animations: { [weak self] in
        self?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self?.alpha = 1
        },
        completion: {  [weak self] _ in
            UIView.animate(withDuration: 0.05) {
                self?.transform = CGAffineTransform.identity
            }
        })
    }
}
