//
//  BalanceView.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 26.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class BalanceView: UIView {
    
    private enum ViewConstants {
        static let padding: CGFloat = 8
    }
    
    private let containerView = UIView()
    private let containerStackView = UIStackView()
    private let headerLabel = UILabel()
    private let amountLabel = UILabel()
    
    public init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func update(headerText: String, amountText: String) {
        headerLabel.text = headerText
        amountLabel.text = amountText
    }
}

// MARK: - View Setup

private extension BalanceView {
    
    func setupViews() {
        setupContainerView()
        setupContainerStackView()
        setupLabels()
    }
    
    func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func setupContainerStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        containerStackView.spacing = ViewConstants.padding
        containerStackView.axis = .vertical
    }
    
    func setupLabels() {
        containerStackView.addArrangedSubview(headerLabel)
        containerStackView.addArrangedSubview(amountLabel)
        
        headerLabel.font = Style.Font.bodyRegular
        headerLabel.textColor = Style.Color.primaryText
        headerLabel.textAlignment = .center
        
        amountLabel.font = Style.Font.header
        amountLabel.textColor = Style.Color.primaryText
        amountLabel.textAlignment = .center
    }
}
