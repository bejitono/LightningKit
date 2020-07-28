//
//  KeypadDigitView.swift
//  LightningKitUI
//
//  Created by De MicheliStefano on 27.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public protocol KeypadDigitViewDelegate: AnyObject {
    func didTap(digit: Int)
}

open class KeypadDigitView: KeypadView {
    
    public let digit: Int
    public weak var delegate: KeypadDigitViewDelegate?
    
    init(digit: Int) {
        self.digit = digit
        super.init()
        setupDigitView()
        tapBlock = { self.delegate?.didTap(digit: digit) }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDigitView() {
        let digitLabel = UILabel()
        digitLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(digitLabel)
        NSLayoutConstraint.activate([
            digitLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            digitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            digitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            digitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        digitLabel.font = UIFont.systemFont(ofSize: 40)
        digitLabel.text = String(digit)
        digitLabel.textColor = Style.Color.primaryText
        digitLabel.textAlignment = .center
    }
}
