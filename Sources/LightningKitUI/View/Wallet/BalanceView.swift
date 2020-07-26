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
        setupContainerStackView()
        setupLabels()
    }
    
    func setupContainerStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
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
