//
//  Wallet.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSSeedCompletion = (Result<LNSSeed, Error>) -> Void
public typealias LNSInitWalletCompletion = (Result<Bool, Error>) -> Void
public typealias LNSUnlockWalletCompletion = (Result<Bool, Error>) -> Void
public typealias LNSWalletBalanceCompletion = (Result<LNSWalletBalance, Error>) -> Void
public typealias LNSTransactionsCompletion = (Result<LNSTransaction, Error>) -> Void
public typealias LNSChannelBalanceCompletion = (Result<LNSChannelBalance, Error>) -> Void

public protocol LNSWallet {
    
    var instantiated: Bool { get }
    
    func generateSeed(completion: @escaping LNSSeedCompletion)
    
    func generateSeed(withConfig config: LNSSeedConfiguration, completion: @escaping LNSSeedCompletion)
    
    func initWalletWith(password: String, seed: LNSSeed, completion: @escaping LNSInitWalletCompletion)
    
    func unlockWallet(withPassword password: String, completion: @escaping LNSUnlockWalletCompletion)
    
    func changeWallet(password: String, to newPassword: String)
    
    func getWalletBalance(completion: @escaping LNSWalletBalanceCompletion)
    
    func getChannelBalance(completion: @escaping LNSChannelBalanceCompletion)
    
    func getTransactions(completion: @escaping LNSTransactionsCompletion)
}
