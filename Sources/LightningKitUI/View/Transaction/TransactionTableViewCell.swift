//
//  TransactionTableViewCell.swift
//  LightningKitUI
//
//  Created by De MicheliStefano on 21.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class TransactionTableViewCell: UITableViewCell {
    
    public struct Model {
        public let txType: String
        public let txAmount: String
        public let status: String
        public let time: String
        public let message: String?
    }

    public static let reuseId = "LightningKitUI.TransactionTableViewCell"
    
    private enum ViewConstants {
        static let padding: CGFloat = 10
        static let spacing: CGFloat = 10
        static let textSpacing: CGFloat = 5
    }
    
    private let containerStackView = UIStackView()
    private let iconImageView = UIImageView()
    private let textStackView = UIStackView()
    private let txAmountStackView = UIStackView()
    private let txTypeLabel = UILabel()
    private let txAmountLabel = UILabel()
    private let txStatusLabel = UILabel()
    private let timestampLabel = UILabel()
    private let messageLabel = UILabel()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(withModel model: Model) {
        txTypeLabel.text = model.txType
        txAmountLabel.text = model.txAmount
        txStatusLabel.text = model.status
        timestampLabel.text = model.time
        messageLabel.text = model.message
    }
}

// MARK: - View Setup

private extension TransactionTableViewCell {
    
    func setupViews() {
        setupContainerStackView()
        setupTextStackView()
        setupTxAmountStackView()
        setupLabels()
    }
    
    func setupContainerStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewConstants.padding),
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: ViewConstants.padding),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewConstants.padding),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewConstants.padding)
        ])
    }
    
    func setupIconImageView() {
        containerStackView.addArrangedSubview(iconImageView)
//        iconImageView.image = UIImage(systemName: "play") // TODO: Replace
        iconImageView.tintColor = Style.Color.success
    }
    
    func setupTextStackView() {
        containerStackView.addArrangedSubview(textStackView)
        textStackView.axis = .vertical
        textStackView.spacing = ViewConstants.textSpacing
    }
    
    func setupTxAmountStackView() {
        textStackView.addArrangedSubview(txAmountStackView)
        textStackView.distribution = .fill
    }
    
    func setupLabels() {
        txAmountStackView.addArrangedSubview(txTypeLabel)
        txAmountStackView.addArrangedSubview(txAmountLabel)
        textStackView.addArrangedSubview(txStatusLabel)
        textStackView.addArrangedSubview(timestampLabel)
        textStackView.addArrangedSubview(messageLabel)
        
        txTypeLabel.textAlignment = .left
        txAmountLabel.textAlignment = .right
        
        txTypeLabel.textColor = Style.Color.primaryText
        txAmountLabel.textColor = Style.Color.primaryText
        txStatusLabel.textColor = Style.Color.primaryText
        timestampLabel.textColor = Style.Color.primaryText
        messageLabel.textColor = Style.Color.primaryText
        
        txTypeLabel.font = Style.Font.bodyLarge
        txAmountLabel.font = Style.Font.bodyLarge
        txStatusLabel.font = Style.Font.bodyRegular
        timestampLabel.font = Style.Font.bodyRegular
        messageLabel.font = Style.Font.bodyRegular
    }
}
