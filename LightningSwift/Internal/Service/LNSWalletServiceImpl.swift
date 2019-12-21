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
    private let mapper: LNSWalletMapper
    
    init(client: LndClient,
         mapper: LNSWalletMapper) {
        self.client = client
        self.mapper = mapper
    }
    
    func generateSeed(completion: @escaping LNSSeedCompletion) {
        client.request(mapper.requestGenerateSeed(withConfig: nil), map: mapper.map(seedResponse:), completion: completion)
    }
    
    func generateSeed(withConfig config: LNSSeedConfiguration, completion: @escaping LNSSeedCompletion) {
        client.request(mapper.requestGenerateSeed(withConfig: config), map: mapper.map(seedResponse:), completion: completion)
    }
    
    func initializeWalletWith(password: String, seed: LNSSeed, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.requestInitWalletWith(password: password, seed: seed), map: mapper.map(initWalletResponse:), completion: completion)
    }
    
    func unlockWallet(withPassword password: String, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.requestUnlockWallet(withPassword: password), map: mapper.map(unlockWalletResponse:), completion: completion)
    }
    
    func changeWallet(password: String, to newPassword: String, completion: @escaping LNSSuccessCompletion) {
        client.request(mapper.requestChange(password: password, to: newPassword), map: mapper.map(changePasswordResponse:), completion: completion)
    }
    
    func getWalletBalance(completion: @escaping LNSWalletBalanceCompletion) {
        client.request(mapper.requestWalletBalance(), map: mapper.map(walletBalanceResponse:), completion: completion)
    }
    
    func getChannelBalance(completion: @escaping LNSChannelBalanceCompletion) {
        client.request(mapper.requestChannelBalance(), map: mapper.map(channelBalanceResponse:), completion: completion)
    }
    
    func getTransactions(completion: @escaping LNSTransactionsCompletion) {
        client.request(mapper.requestTransactions(), map: mapper.map(transactionsResponse:), completion: completion)
    }
}
