//
//  UIView+Transform.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 16.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

extension UIView {
    
    func applyTransform(
        isHighlighted: Bool,
        animationDuration: TimeInterval = 0.1,
        resizeScale: CGFloat = 0.95
    ) {
        if isHighlighted {
            UIView.animate(withDuration: animationDuration) {
                self.transform = CGAffineTransform(scaleX: resizeScale, y: resizeScale)
            }
        } else {
            UIView.animate(withDuration: animationDuration) {
                self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
    }
}
