//
//  UIView+Effects.swift
//  freeza
//
//  Created by Cesar Brenes on 12/17/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import UIKit

protocol BlurableProtocol {
    func addBlur(alpha: CGFloat)
}

extension BlurableProtocol where Self: UIView {
    func addBlur(alpha: CGFloat = 0.5) {
        let effect = UIBlurEffect(style: .dark)
        let effectView = UIVisualEffectView(effect: effect)
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = alpha
        self.addSubview(effectView)
    }
}

extension UIView: BlurableProtocol {}
