//
//  ShakeyBellView.swift
//  BankeyApp
//
//  Created by Олег Федоров on 18.01.2022.
//

import Foundation
import UIKit

class ShakeyBellView: UIView {
    
    let imageView = UIImageView()
    
    let buttonView = UIButton()
    let buttonHeight: CGFloat = 16
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        layout()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 48, height: 48)
    }
}

// MARK: - SetupUI
extension ShakeyBellView {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "bell.fill")?.withTintColor(
            .white,
            renderingMode: .alwaysOriginal
        )
        imageView.image = image
        
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .systemRed
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buttonView.layer.cornerRadius = buttonHeight / 2
        buttonView.setTitle("9", for: .normal)
        buttonView.setTitleColor(.white, for: .normal)
    }
    
    func layout() {
        addSubview(imageView)
        addSubview(buttonView)
        
        // imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        // buttonView
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: imageView.topAnchor),
            buttonView.leadingAnchor.constraint(
                equalTo: imageView.trailingAnchor, constant: -9
            ),
            buttonView.widthAnchor.constraint(equalToConstant: buttonHeight),
            buttonView.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    func setup() {
        let singleTap = UITapGestureRecognizer(
            target: self, action: #selector(imageViewTapped)
        )
        imageView.addGestureRecognizer(singleTap)
        imageView.isUserInteractionEnabled = true
    }
}

// MARK: - Actions
extension ShakeyBellView {
    @objc func imageViewTapped() {
        shakeWith(duration: 1.0, angle: .pi / 8, yOffset: 0.0)
    }
    
    private func shakeWith(duration: Double, angle: CGFloat, yOffset: CGFloat) {
        let numberOfFrames = 6.0
        let frameDuration = 1 / numberOfFrames
        
        imageView.setAnchorPoint(CGPoint(x: 0.5, y: yOffset))
        
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: []) {
            UIView.addKeyframe(
                withRelativeStartTime: 0.0,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 2,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 3,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: +angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 4,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform(rotationAngle: -angle)
            }
            
            UIView.addKeyframe(
                withRelativeStartTime: frameDuration * 5,
                relativeDuration: frameDuration
            ) {
                self.imageView.transform = CGAffineTransform.identity
            }
        }
    }
}
