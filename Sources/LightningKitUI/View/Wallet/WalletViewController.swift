//
//  WalletViewController.swift
//  LightningKitApp
//
//  Created by De MicheliStefano on 26.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

protocol WalletViewControllerDelegate: AnyObject {
    func didTapSeeAllTransactions()
}


open class WalletViewController: UIViewController {
    
    weak var delegate: WalletViewControllerDelegate?
    
    private enum ViewConstants {
        static let padding: CGFloat = 8
    }
    
    private let balanceView = BalanceView()
    private let transactionsStackView = UIStackView()
    private let transactionsHeaderLabel = UILabel()
    private let seeAllTransactionsLabel = UILabel()
    private let transactionsOverviewTableView = TransactionsTableViewController()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        setupViews()
        balanceView.update(headerText: "Balance", amountText: "$23298.232")
    }
}

// MARK: - Actions

extension WalletViewController {
    
    @objc func didTapSeeAllTx(sender: UITapGestureRecognizer) {
        delegate?.didTapSeeAllTransactions()
    }
}

// MARK: - View Setup

private extension WalletViewController {
    
    func setupViews() {
        super.viewDidLoad()
        setupBalanceView()
        setupTransactionsOverview()
        setupTransactionsLabels()
        view.backgroundColor = Style.Color.primaryBackground
    }
    
    func setupBalanceView() {
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(balanceView)
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            balanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.padding),
            balanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.padding),
            balanceView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupTransactionsOverview() {
        transactionsStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transactionsStackView)
        NSLayoutConstraint.activate([
            transactionsStackView.topAnchor.constraint(equalTo: balanceView.bottomAnchor),
            transactionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ViewConstants.padding),
            transactionsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            transactionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ViewConstants.padding)
        ])
        
        let headerStackView = UIStackView()
        headerStackView.addArrangedSubview(transactionsHeaderLabel)
        headerStackView.addArrangedSubview(seeAllTransactionsLabel)
        
        transactionsStackView.addArrangedSubview(headerStackView)
        transactionsStackView.addArrangedSubview(transactionsOverviewTableView.view)
        
        transactionsStackView.axis = .vertical
        
        headerStackView.distribution = .fillProportionally
    }
    
    func setupTransactionsLabels() {
        transactionsHeaderLabel.font = Style.Font.bodyRegular
        transactionsHeaderLabel.text = "Transactions Overview" // TODO: Localize
            
        seeAllTransactionsLabel.text = "See all" // TODO: Localize
        seeAllTransactionsLabel.textAlignment = .right
        seeAllTransactionsLabel.font = Style.Font.bodyLarge
        seeAllTransactionsLabel.textColor = Style.Color.primaryAction
        seeAllTransactionsLabel.isUserInteractionEnabled = true
        seeAllTransactionsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(didTapSeeAllTx)))
    }
}
