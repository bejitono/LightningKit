//
//  TxAmountDigitView.swift
//  LightningKitUI
//
//  Created by De MicheliStefano on 28.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class TxAmountDigitView: UIView {
    
    public let digit: Int
    
    private enum ViewConstants {
        static let offset: CGFloat = -50
        static let animationDurationOnEnter = TimeInterval(0.4)
        static let animationDurationOnDeparture = TimeInterval(0.2)
        static let animationDamping: CGFloat = 0.8
    }
    
    private let contentView = UIView()
    private let digitLabel = UILabel()
    private var initialDigitYAnchor: NSLayoutConstraint?
    private var enteredDigitYAnchor: NSLayoutConstraint?
    
    public init(digit: Int) {
        self.digit = digit
        super.init(frame: .zero)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func animateEntry(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: ViewConstants.animationDurationOnEnter,
            delay: 0,
            usingSpringWithDamping: ViewConstants.animationDamping,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
            self.initialDigitYAnchor?.isActive = false
            self.enteredDigitYAnchor?.isActive = true
            self.digitLabel.alpha = 1
            self.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }
    
    public func animateDeparture(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: ViewConstants.animationDurationOnDeparture,
            delay: 0,
            usingSpringWithDamping: ViewConstants.animationDamping,
            initialSpringVelocity: 1,
            options: .curveEaseIn,
            animations: {
            self.initialDigitYAnchor?.isActive = true
            self.enteredDigitYAnchor?.isActive = false
            self.digitLabel.alpha = 0
            self.layoutIfNeeded()
        }, completion: { _ in
            completion?()
        })
    }
}

// MARK: - View Setup

private extension TxAmountDigitView {
    
    func setupViews() {
        setupContentView()
        setupDigitLabel()
    }
    
    func setupContentView() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func setupDigitLabel() {
        digitLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(digitLabel)
        NSLayoutConstraint.activate([
            digitLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            digitLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        initialDigitYAnchor = digitLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: ViewConstants.offset)
        initialDigitYAnchor?.isActive = true
        enteredDigitYAnchor = digitLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        enteredDigitYAnchor?.isActive = false
        
        digitLabel.font = UIFont.boldSystemFont(ofSize: 80) // TODO: Use styles
        digitLabel.text = String(digit)
        digitLabel.textColor = Style.Color.primaryText
        digitLabel.textAlignment = .center
        digitLabel.alpha = 0
        digitLabel.adjustsFontSizeToFitWidth = true
    }
}
