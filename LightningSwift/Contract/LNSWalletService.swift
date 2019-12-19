//
//  Wallet.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSSeedCompletion = (Result<LNSSeed, LNSWalletError>) -> Void
public typealias LNSInitWalletCompletion = (Result<Bool, LNSWalletError>) -> Void
public typealias LNSUnlockWalletCompletion = (Result<Bool, LNSWalletError>) -> Void
public typealias LNSWalletBalanceCompletion = (Result<LNSWalletBalance, LNSWalletError>) -> Void
public typealias LNSTransactionsCompletion = (Result<LNSTransaction, LNSWalletError>) -> Void
public typealias LNSChannelBalanceCompletion = (Result<LNSChannelBalance, LNSWalletError>) -> Void

public protocol LNSWalletService {
    
    var initialized: Bool { get }
    
    var unlocked: Bool { get }
    
    func generateSeed(completion: @escaping LNSSeedCompletion) // TODO: Hide implementation detail
    
    func generateSeed(withConfig config: LNSSeedConfiguration, completion: @escaping LNSSeedCompletion) // TODO: Hide implementation detail
    
    func initializeWalletWith(password: String, seed: LNSSeed, completion: @escaping LNSInitWalletCompletion)
    
    func unlockWallet(withPassword password: String, completion: @escaping LNSUnlockWalletCompletion)
    
    func changeWallet(password: String, to newPassword: String)
    
    func getWalletBalance(completion: @escaping LNSWalletBalanceCompletion)
    
    func getChannelBalance(completion: @escaping LNSChannelBalanceCompletion)
    
    func getTransactions(completion: @escaping LNSTransactionsCompletion)
}
