//
//  SeedPhraseView.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 20.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class SeedPhraseView: UIView {
    
    public let index: Int
    public let seedPhrase: String
    
    private enum ViewConstants {
        static let padding: CGFloat = 10
        static let borderWidth: CGFloat = 2
        static let spacing: CGFloat = 7
        static let indexSize: CGFloat = 25
        static let indexPadding: CGFloat = 3
    }
    
    private let containerStackView = UIStackView()
    private let indexView = UIView()
    private let seedPhraseLabel = UILabel()
    private let indexLabel = UILabel()
    
    public init(index: Int, seedPhrase: String) {
        self.index = index
        self.seedPhrase = seedPhrase
        super.init(frame: .zero)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.height * 0.5
    }
}

// MARK: - Setup Views

private extension SeedPhraseView {
    
    func setupViews() {
        layer.borderWidth = ViewConstants.borderWidth
        layer.borderColor = Style.Color.shadow.cgColor
        
        setupContainerStackView()
        setupIndexView()
        setupIndexLabel()
        setupSeedPhraseLabel()
    }
    
    func setupContainerStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewConstants.padding),
            containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: ViewConstants.padding),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ViewConstants.padding),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -ViewConstants.padding),
        ])
        containerStackView.distribution = .fillProportionally
        containerStackView.spacing = ViewConstants.spacing
    }
    
    func setupIndexView() {
        containerStackView.addArrangedSubview(indexView)
        NSLayoutConstraint.activate([
            indexView.heightAnchor.constraint(equalToConstant: ViewConstants.indexSize),
            indexView.widthAnchor.constraint(equalToConstant: ViewConstants.indexSize)
        ])
        indexView.layer.cornerRadius = ViewConstants.indexSize / 2
        indexView.clipsToBounds = true
        indexView.backgroundColor = Style.Color.primaryAction
    }
    
    func setupIndexLabel() {
        indexLabel.translatesAutoresizingMaskIntoConstraints = false
        indexView.addSubview(indexLabel)
        NSLayoutConstraint.activate([
            indexLabel.leadingAnchor.constraint(equalTo: indexView.leadingAnchor, constant: ViewConstants.indexPadding),
            indexLabel.topAnchor.constraint(equalTo: indexView.topAnchor, constant: ViewConstants.indexPadding),
            indexLabel.trailingAnchor.constraint(equalTo: indexView.trailingAnchor, constant: -ViewConstants.indexPadding),
            indexLabel.bottomAnchor.constraint(equalTo: indexView.bottomAnchor, constant: -ViewConstants.indexPadding),
        ])
        indexLabel.text = String(index)
        indexLabel.textColor = Style.Color.lightText
        indexLabel.textAlignment = .center
        indexLabel.font = Style.Font.bodySmall
    }
    
    func setupSeedPhraseLabel() {
        containerStackView.addArrangedSubview(seedPhraseLabel)
        seedPhraseLabel.text = seedPhrase
        seedPhraseLabel.textColor = Style.Color.primaryText
        seedPhraseLabel.font = Style.Font.bodyRegular
    }
}
