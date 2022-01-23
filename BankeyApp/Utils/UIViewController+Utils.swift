//
//  UIViewController+Utils.swift
//  BankeyApp
//
//  Created by Олег Федоров on 11.01.2022.
//

import UIKit

extension UIViewController {
    func setTabBarImage(imageName: String, title: String) {
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName,
                            withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
}
