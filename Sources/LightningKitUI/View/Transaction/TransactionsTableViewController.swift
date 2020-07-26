//
//  TransactionsTableViewController.swift
//  LightningKitUI
//
//  Created by De MicheliStefano on 26.07.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import UIKit

open class TransactionsTableViewController: UITableViewController {
    
    let models = [TransactionTableViewCell.Model(txType: "ln", txAmount: "234 sats", status: "done", time: "23/3/18", message: nil), TransactionTableViewCell.Model(txType: "ln", txAmount: "234 sats", status: "done", time: "23/3/18", message: "what up")]

    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        setupViews()
    }

    // MARK: - Table view data source

    open override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    open override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { models.count }

    open override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.reuseId, for: indexPath) as! TransactionTableViewCell

        let model = models[indexPath.row]
        
        cell.configure(withModel: model)

        return cell
    }
}

// MARK: - View Setup

private extension TransactionsTableViewController {
    
    func setupViews() {
        tableView.tableFooterView = UIView()
        tableView.alwaysBounceVertical = false
    }
}
