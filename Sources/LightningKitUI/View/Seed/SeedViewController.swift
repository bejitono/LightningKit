//
//  SeedViewController.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 16.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

public protocol SeedViewControllerDelegate: AnyObject {
    func didTapDone()
}

open class SeedViewController: UIViewController {
    
    public weak var delegate: SeedViewControllerDelegate?
    
    private enum ViewConstants {
        static let padding: CGFloat = 10
        static let buttonHeight: CGFloat = 45
        static let bottomInset: CGFloat = 55
    }
    
    private let seedView: SeedListView
    private let buttonView = Button()
    
    public init(seed: [String]) {
        seedView = SeedListView(seed: seed)
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        buttonView.delegate = self
    }
}

// MARK: - View Setup

private extension SeedViewController {
    
    func setupViews() {
        setupButtonView()
        setupSeedView()
        view.backgroundColor = Style.Color.primaryBackground
    }
    
    func setupSeedView() {
        seedView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(seedView)
        NSLayoutConstraint.activate([
            seedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seedView.topAnchor.constraint(equalTo: view.topAnchor),
            seedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            seedView.bottomAnchor.constraint(equalTo: buttonView.topAnchor, constant: -ViewConstants.padding)
        ])
        seedView.scrollView.contentInsetAdjustmentBehavior = .never
        seedView.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ViewConstants.bottomInset, right: 0)
    }
    
    func setupButtonView() {
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonView)
        NSLayoutConstraint.activate([
            buttonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.padding),
            buttonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.padding),
            buttonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -ViewConstants.padding),
            buttonView.heightAnchor.constraint(equalToConstant: ViewConstants.buttonHeight)
        ])
        buttonView.setTitle("Setup wallet") // TODO: localization
    }
}

// MARK: ButtonDelegate

extension SeedViewController: ButtonDelegate {
    
    public func didTap() {
        delegate?.didTapDone()
    }
}
