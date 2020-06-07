//
//  Wallet.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 14.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSSeedCompletion = (Result<LNSSeed, Error>) -> Void
public typealias LNSWalletBalanceCompletion = (Result<LNSWalletBalance, Error>) -> Void
public typealias LNSTransactionsCompletion = (Result<[LNSTransaction], Error>) -> Void
public typealias LNSChannelBalanceCompletion = (Result<LNSChannelBalance, Error>) -> Void
public typealias LNSNewAddressCompletion = (Result<BTCAddress, Error>) -> Void
public typealias LNSSendCoinsCompletion = (Result<LNSTransactionId, Error>) -> Void

public protocol LNSWalletService {
    
    var initialized: Bool { get }
    
    var unlocked: Bool { get }
    
    func generateSeed(completion: @escaping LNSSeedCompletion) // TODO: Hide implementation detail
    
    func generateSeed(withConfig config: LNSSeedConfiguration, completion: @escaping LNSSeedCompletion) // TODO: Hide implementation detail
    
    func initializeWith(password: String, seed: [String], completion: @escaping LNSSuccessCompletion)
    
    func unlock(withPassword password: String, completion: @escaping LNSSuccessCompletion)
    
    // TODO: Add wallet recovery with seed
    
    func change(password: String, toNewPassword newPassword: String, completion: @escaping LNSSuccessCompletion)
    
    func getWalletBalance(completion: @escaping LNSWalletBalanceCompletion)
    
    func getChannelBalance(completion: @escaping LNSChannelBalanceCompletion)
    
    func getTransactions(completion: @escaping LNSTransactionsCompletion)
    
    func generateNewAddress(forType type: LNSAddressType, completion: @escaping LNSNewAddressCompletion)
    
    func generateNewAddress(completion: @escaping LNSNewAddressCompletion)
    
    func sendCoins(withConfig config: LNSSendCoinsConfiguration, completion: @escaping LNSSendCoinsCompletion)
}
