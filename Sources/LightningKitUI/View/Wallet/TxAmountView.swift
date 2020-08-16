//
//  TxAmountView.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 29.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class TxAmountView: UIView {
    
    private var amount: [Int] = []
    private var amountViews: [TxAmountDigitView] = []
    private let amountStackView = UIStackView()
    
    public init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func append(digit: Int) {
        let digitView = TxAmountDigitView(digit: digit)
        amountStackView.addArrangedSubview(digitView)
        amountViews.append(digitView)
        layoutIfNeeded()
        digitView.animateEntry()
    }
    
    open func pop() {
        guard let digitView = amountViews.popLast() else { return }
        digitView.animateDeparture {
            self.amountStackView.removeArrangedSubview(digitView)
            digitView.removeFromSuperview()
        }
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
        
        amountStackView.distribution = .fillProportionally
    }
}
