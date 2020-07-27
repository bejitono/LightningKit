//
//  KeypadView.swift
//  LightningKitUI
//
//  Created by De MicheliStefano on 27.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class KeypadView: UIView {
    
    public let contentView = UIView()
    
    private enum ViewConstants {
        static let underlineHeight: CGFloat = 1
        static let underLineAlpha: CGFloat = 0.5
        static let underLineAnimationAlpha: CGFloat = 1
        static let transformScale: CGFloat = 1.8
        static let animationDuration = TimeInterval(0.08)
    }
    
    private let underlineView = UIView()

    public init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func animate() {
        UIView.animate(withDuration: ViewConstants.animationDuration, animations: {
            self.contentView.transform = CGAffineTransform(scaleX: ViewConstants.transformScale, y: ViewConstants.transformScale)
            self.underlineView.alpha = ViewConstants.underLineAnimationAlpha
        }) { _ in
            UIView.animate(withDuration: ViewConstants.animationDuration) {
                self.contentView.transform = CGAffineTransform.identity
                self.underlineView.alpha = ViewConstants.underLineAlpha
            }
        }
    }
}

// MARK: - View Setup

private extension KeypadView {
    
    func setupViews() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        setupUnderlineView()
        setupDigitView()
    }
    
    func setupDigitView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: underlineView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func setupUnderlineView() {
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(underlineView)
        NSLayoutConstraint.activate([
            underlineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            underlineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: ViewConstants.underlineHeight)
        ])
        
        underlineView.backgroundColor = Style.Color.primaryText
        underlineView.alpha = ViewConstants.underLineAlpha
    }
}
