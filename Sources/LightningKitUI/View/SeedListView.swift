//
//  SeedView.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 15.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class SeedListView: UIView {
    
    public let seed: [String]
    public let scrollView = UIScrollView()
    
    private enum ViewConstants {
        static let padding: CGFloat = 10
        static let spacing: CGFloat = 5
    }
    
    private let containerStackView = UIStackView()
    private let firstSeedStackView = UIStackView()
    private let secondSeedStackView = UIStackView()
    
    public init(seed: [String]) {
        self.seed = seed
        super.init(frame: .zero)
        setupViews()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup Views

private extension SeedListView {
    
    func setupViews() {
        setupScrollView()
        setupContainerStackView()
        setupFirstSeedStackView()
        setupSecondSeedStackView()
        setupSeedLabels(withSeed: seed)
    }
    
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func setupContainerStackView() {
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerStackView)
        NSLayoutConstraint.activate([
            containerStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: ViewConstants.padding),
            containerStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: ViewConstants.padding),
            containerStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -ViewConstants.padding),
            containerStackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor, multiplier: 1, constant: -ViewConstants.padding * 2)
        ])
        containerStackView.spacing = ViewConstants.spacing
        containerStackView.distribution = .fillEqually
    }
    
    func setupFirstSeedStackView() {
        containerStackView.addArrangedSubview(firstSeedStackView)
        firstSeedStackView.axis = .vertical
        firstSeedStackView.spacing = ViewConstants.spacing
    }
    
    func setupSecondSeedStackView() {
        containerStackView.addArrangedSubview(secondSeedStackView)
        secondSeedStackView.axis = .vertical
        secondSeedStackView.spacing = ViewConstants.spacing
    }
    
    func setupSeedLabels(withSeed seed: [String]) {
        for (index, word) in seed.enumerated() {
            let seedPhraseView = SeedPhraseView(index: index + 1, seedPhrase: word)
            if index < seed.count / 2 {
                firstSeedStackView.addArrangedSubview(seedPhraseView)
            } else {
                secondSeedStackView.addArrangedSubview(seedPhraseView)
            }
        }
    }
}
