//
//  LNSWalletServiceImplementation.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 19.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

final class LNSWalletServiceImplementation: LNSWalletService {
    
    var initialized: Bool = false
    var unlocked: Bool = false
    
    private let client: LndClient
    
    init(client: LndClient) {
        self.client = client
    }
    
    func generateSeed(completion: @escaping LNSSeedCompletion) {
        
    }
    
    func generateSeed(withConfig config: LNSSeedConfiguration, completion: @escaping LNSSeedCompletion) {
        
    }
    
    func initializeWalletWith(password: String, seed: LNSSeed, completion: @escaping LNSInitWalletCompletion) {
        
    }
    
    func unlockWallet(withPassword password: String, completion: @escaping LNSUnlockWalletCompletion) {
        
    }
    
    func changeWallet(password: String, to newPassword: String) {
        
    }
    
    func getWalletBalance(completion: @escaping LNSWalletBalanceCompletion) {
        
    }
    
    func getChannelBalance(completion: @escaping LNSChannelBalanceCompletion) {
        
    }
    
    func getTransactions(completion: @escaping LNSTransactionsCompletion) {
        
    }
}
