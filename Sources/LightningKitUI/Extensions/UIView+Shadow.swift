//
//  UIView+Shadow.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 20.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public extension UIView {
    
    enum DefaultStyle {
        static let alpha: Float = 1.0
        static let blur: CGFloat = 5.0
        static let spread: CGFloat = 0
        static let cornerRadius: CGFloat = 8.0
    }
    
    func applyShadow(
        color: UIColor,
        alpha: Float = DefaultStyle.alpha,
        toSide side: Sides = .bottom,
        blur: CGFloat = DefaultStyle.blur,
        spread: CGFloat = DefaultStyle.spread
    ) {
        let point = offset(for: side)
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: point.x, height: point.y)
        layer.shadowRadius = blur / 2.0
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = layer.bounds.insetBy(dx: dx, dy: dx)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UIView {
    
    enum Sides {
        case top
        case bottom
        case custom(x: CGFloat, y: CGFloat)
    }
    
    func offset(for side: Sides) -> CGPoint {
        switch side {
        case .top: return CGPoint(x: 0, y: -5)
        case .bottom: return CGPoint(x: 0, y: 3)
        case .custom(x: let x, y: let y): return CGPoint(x: x, y: y)
        }
    }
}
