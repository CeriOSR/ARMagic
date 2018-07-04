//
//  UIButton+Helper.swift
//  Pods
//
//  Created by Brian Voong on 11/30/16.
//
//

import UIKit

extension UIButton {
    static public func systemButton(title: String? = nil, image: UIImage? = nil, titleColor: UIColor? = .white, font: UIFont? = nil, target: Any? = nil, selector: Selector? = nil) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: UIControl.State.normal)
        button.setImage(image?.withRenderingMode(.alwaysOriginal), for: UIControl.State.normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitleColor(titleColor, for: UIControl.State.normal)
        button.titleLabel?.font = font
        if let selector = selector {
            button.addTarget(target, action: selector, for: UIControl.Event.touchUpInside)
        }
        return button
    }
}
