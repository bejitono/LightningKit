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
    var tapBlock: (() -> Void)?
    
    private enum ViewConstants {
        static let underlineHeight: CGFloat = 1.5
        static let underLineAlpha: CGFloat = 0.3
        static let underLineAnimationAlpha: CGFloat = 1
        static let transformScale: CGFloat = 1.8
        static let animationDuration = TimeInterval(0.08)
        static let minimumPressDuration = TimeInterval(0.2)
    }
    
    private let underlineView = UIView()

    public init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Animation

private extension KeypadView {
    
    @objc
    private func animateOnTap() {
        UIView.animate(withDuration: ViewConstants.animationDuration, animations: {
            self.scaleContentView()
        }) { _ in
            UIView.animate(withDuration: ViewConstants.animationDuration) {
                self.descaleContentView()
            }
            self.tapBlock?()
        }
    }
    
    @objc
    private func animateOnLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            UIView.animate(withDuration: ViewConstants.animationDuration) {
                self.scaleContentView()
            }
        } else if sender.state == .ended {
            UIView.animate(withDuration: ViewConstants.animationDuration) {
                self.descaleContentView()
            }
            self.tapBlock?()
        }
    }
    
    private func scaleContentView() {
        contentView.transform = CGAffineTransform(scaleX: ViewConstants.transformScale, y: ViewConstants.transformScale)
        underlineView.alpha = ViewConstants.underLineAnimationAlpha
    }
    
    private func descaleContentView() {
        contentView.transform = CGAffineTransform.identity
        underlineView.alpha = ViewConstants.underLineAlpha
    }
}

// MARK: - View Setup

private extension KeypadView {
    
    func setupViews() {
        setupUnderlineView()
        setupDigitView()
        setupGestureRecognizers()
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
    
    func setupGestureRecognizers() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOnTap)))
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(animateOnLongPress))
        longPressRecognizer.minimumPressDuration = ViewConstants.minimumPressDuration
        addGestureRecognizer(longPressRecognizer)
    }
}
