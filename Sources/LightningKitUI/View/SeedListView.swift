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
    
    private let seedStackView = UIStackView()
    
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
        setupSeedStackView()
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
    
    func setupSeedStackView() {
        seedStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(seedStackView)
        NSLayoutConstraint.activate([
            seedStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: ViewConstants.padding),
            seedStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: ViewConstants.padding),
            seedStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -ViewConstants.padding),
            seedStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -ViewConstants.padding)
        ])
        seedStackView.axis = .vertical
        seedStackView.spacing = ViewConstants.spacing
    }
    
    func setupSeedLabels(withSeed seed: [String]) {
        for (index, word) in seed.enumerated() {
            let seedPhraseView = SeedPhraseView(index: index, seedPhrase: word)
            seedStackView.addArrangedSubview(seedPhraseView)
        }
    }
}
