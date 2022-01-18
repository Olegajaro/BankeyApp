//
//  UIView + AnchorPoint.swift
//  BankeyApp
//
//  Created by Олег Федоров on 18.01.2022.
//

import UIKit

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(
            x: bounds.size.width * point.x,
            y: bounds.size.height * point.y
        )
        var oldPoint = CGPoint(
            x: bounds.size.width * layer.anchorPoint.x,
            y: bounds.size.height * layer.anchorPoint.y
        )
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}
