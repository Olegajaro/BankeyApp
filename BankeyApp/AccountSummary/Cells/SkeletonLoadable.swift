//
//  SkeletonLoadable.swift
//  BankeyApp
//
//  Created by Олег Федоров on 21.01.2022.
//

import Foundation
import QuartzCore
import UIKit

protocol SkeletonLoadable {}

extension SkeletonLoadable {
    
    func makeAnimationGroup(
        previousGroup: CAAnimationGroup? = nil
    ) -> CAAnimationGroup {
        let animDuration: CFTimeInterval = 1.5
        
        let animation1 = CABasicAnimation(
            keyPath: #keyPath(CAGradientLayer.backgroundColor)
        )
        animation1.fromValue = UIColor.gradientLightGrey.cgColor
        animation1.toValue = UIColor.gradientDarkGrey.cgColor
        animation1.duration = animDuration
        animation1.beginTime = 0.0
        
        let animation2 = CABasicAnimation(
            keyPath: #keyPath(CAGradientLayer.backgroundColor)
        )
        animation2.fromValue = UIColor.gradientDarkGrey.cgColor
        animation2.toValue = UIColor.gradientLightGrey.cgColor
        animation2.duration = animDuration
        animation2.beginTime = animation1.beginTime + animation1.duration
        
        let group = CAAnimationGroup()
        group.animations = [animation1, animation2]
        group.repeatCount = .greatestFiniteMagnitude // infinite
        group.duration = animation2.beginTime + animation2.duration
        group.isRemovedOnCompletion = false
        
        if let previousGroup = previousGroup {
            // Offset groups by 0.33 seconds for effect
            group.beginTime = previousGroup.beginTime + 0.33
        }
        
        return group
    }
}

extension UIColor {
    static var gradientDarkGrey: UIColor {
        UIColor(red: 239 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
    }
    
    static var gradientLightGrey: UIColor {
        UIColor(red: 201 / 255, green: 201 / 255, blue: 201 / 255, alpha: 1 )
    }
}
