//
//  TxAmountView.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 29.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class TxAmountView: UIView {
    
    private enum ViewConstants {
        static let animationDuration: TimeInterval = 0.1
    }
    
    private var amount: [Int] = []
    private var amountViews: [TxAmountDigitView] = []
    private let amountStackView = UIStackView()
    private let leftSpacer = UIView()
    private let rightSpacer = UIView()
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func append(digit: Int) {
        let digitView = TxAmountDigitView(digit: digit)
        amountStackView.insertArrangedSubview(digitView, at: amountStackView.subviews.count - 1)
        amountViews.append(digitView)
        animatedLayoutIfNeeded { _ in
            digitView.animateEntry()
        }
    }
    
    open func pop() {
        guard let digitView = amountViews.popLast() else { return }
        digitView.animateDeparture {
            self.amountStackView.removeArrangedSubview(digitView)
            digitView.removeFromSuperview()
            self.animatedLayoutIfNeeded()
        }
    }
}

// MARK: - Animation

private extension TxAmountView {
    
    func animatedLayoutIfNeeded(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(
            withDuration: ViewConstants.animationDuration,
            animations: { self.layoutIfNeeded() },
            completion: completion
        )
    }
}

// MARK: - View Setup

private extension TxAmountView {
    
    func setupView() {
        setupAmountStackView()
    }
    
    func setupAmountStackView() {
        amountStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(amountStackView)
        NSLayoutConstraint.activate([
            amountStackView.topAnchor.constraint(equalTo: topAnchor),
            amountStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            amountStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            amountStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        amountStackView.addArrangedSubview(leftSpacer)
        amountStackView.addArrangedSubview(rightSpacer)
        leftSpacer.widthAnchor.constraint(equalTo: rightSpacer.widthAnchor).isActive = true
        amountStackView.distribution = .fill
    }
}
