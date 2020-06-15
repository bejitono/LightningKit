//
//  SeedView.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 15.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class SeedView: UIView {
    
    private enum Constants {
        static let padding: CGFloat: 10
    }
    
    public let seed: [String]
    
    private let scrollView: UIScrollView()
    private let seedStackView: UIStackView()
    
    init(seed: [String]) {
        self.seed = seed
        super.init(frame: .zero)
        setupViews()
    }
}

// MARK: - Private

private extension SeedView {
    
    func setupViews() {
        setupScrollView()
        setupSeedStackView()
        setupSeedLabels(withSeed: seed)
    }
    
    func setupScrollView() {
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    func setupSeedStackView() {
        scrollView.addSubview(seedStackView)
        NSLayoutConstraint.activate([
            seedStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            seedStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            seedStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            seedStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        ])
    }
    
    func setupSeedLabels(withSeed seed: [String]) {
        for (index, word) in seed.enumerated() {
            let label = UILabel()
            seedStackView.addArrangedSubview(label)
            label.text = "\(index). \(word)"
            label.textColor = .black // TODO: Implement Color object
        }
    }
}
