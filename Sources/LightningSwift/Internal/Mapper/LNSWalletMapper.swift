//
//  WalletMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 20.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

typealias LNSWalletMapper = LNSWalletResponseMapper

protocol LNSWalletResponseMapper {
    
    func map(seedResponse response: Lnrpc_GenSeedResponse) -> LNSSeed
    
    func map(initWalletResponse response: Lnrpc_InitWalletResponse) -> Bool
    
    func map(unlockWalletResponse response: Lnrpc_UnlockWalletResponse) -> Bool
    
    func map(changePasswordResponse response: Lnrpc_ChangePasswordResponse) -> Bool
    
    func map(walletBalanceResponse response: Lnrpc_WalletBalanceResponse) -> LNSWalletBalance
    
    func map(channelBalanceResponse response: Lnrpc_ChannelBalanceResponse) -> LNSChannelBalance
    
    func map(transactionsResponse response: Lnrpc_TransactionDetails) -> [LNSTransaction]
    
    func map(newAddressResponse response: Lnrpc_NewAddressResponse) -> BTCAddress
    
    func map(sendCoinsResponse response: Lnrpc_SendCoinsResponse) -> LNSTransactionId
}

// MARK: - Request mapping

extension Lnrpc_GenSeedRequest {
    
    init(config: LNSSeedConfiguration?) {
        var req = Lnrpc_GenSeedRequest()
        guard let config = config else {
            self = req
            return
        }
        req.aezeedPassphrase = config.passphrase
        req.seedEntropy = config.entropy
        self = req
    }
}

extension Lnrpc_InitWalletRequest {
    
    init(password: String, seed: [String]) {
        var req = Lnrpc_InitWalletRequest()
        guard let passwordData = password.data(using: .utf8) else {
            self = req
            return
        }
        req.walletPassword = passwordData
        req.cipherSeedMnemonic = seed
        // TODO: getting error "invalid passphrase"
        //if let encipheredSeed = seed.encipheredSeed { req.aezeedPassphrase = encipheredSeed }
        self = req
    }
}

extension Lnrpc_ChangePasswordRequest {
    
    init(password: String, to newPassword: String) {
        var req = Lnrpc_ChangePasswordRequest()
        guard
            let passwordData = password.data(using: .utf8),
            let newPasswordData = newPassword .data(using: .utf8)
        else {
            self = req
            return
        }
        req.currentPassword = passwordData
        req.newPassword = newPasswordData
        self = req

    }
}

extension Lnrpc_UnlockWalletRequest {
    
    init(password: String) {
        var req = Lnrpc_UnlockWalletRequest()
        guard let passwordData = password.data(using: .utf8) else {
            self = req
            return
        }
        req.walletPassword = passwordData
        self = req
    }
}

extension Lnrpc_NewAddressRequest {
    
    init(type: LNSAddressType?) {
        var req = Lnrpc_NewAddressRequest()
        guard let type = type else {
            self = req
            return
        }
        req.type = type.lndAddressType
        self = req
    }
}

extension Lnrpc_SendCoinsRequest {
    
    init(config: LNSSendCoinsConfiguration) {
        var req = Lnrpc_SendCoinsRequest()
        req.addr = config.address
        req.amount = Int64(config.amount)
        req.targetConf = Int32(config.targetConfirmations)
        req.sendAll = config.sendAll
        self = req
    }
}

// MARK: - Response mapping

extension LNSSeed {
    
    init(response: Lnrpc_GenSeedResponse) {
        self = .init(phrase: response.cipherSeedMnemonic, encipheredSeed: response.encipheredSeed)
    }
}

struct LNSWalletMapperImplementation: LNSWalletResponseMapper {
    
    func map(seedResponse response: Lnrpc_GenSeedResponse) -> LNSSeed {
        return LNSSeed(phrase: response.cipherSeedMnemonic, encipheredSeed: response.encipheredSeed)
    }
    
    func map(initWalletResponse response: Lnrpc_InitWalletResponse) -> Bool {
        return true
    }
    
    func map(unlockWalletResponse response: Lnrpc_UnlockWalletResponse) -> Bool {
        return true
    }
    
    func map(changePasswordResponse response: Lnrpc_ChangePasswordResponse) -> Bool {
        return true
    }
    
    func map(walletBalanceResponse response: Lnrpc_WalletBalanceResponse) -> LNSWalletBalance {
        return LNSWalletBalance(
            totalBalance: Int(response.totalBalance),
            confirmedBalance: Int(response.confirmedBalance),
            unconfirmedBalance: Int(response.unconfirmedBalance)
        )
    }
    
    func map(channelBalanceResponse response: Lnrpc_ChannelBalanceResponse) -> LNSChannelBalance {
        return LNSChannelBalance(balance: Int(response.balance), pendingBalance: Int(response.pendingOpenBalance))
    }
    
    func map(transactionsResponse response: Lnrpc_TransactionDetails) -> [LNSTransaction] {
        return response.transactions.map {
            LNSTransaction(
                hash: $0.txHash,
                amount: Int($0.amount),
                numberOfConfirmations: Int($0.numConfirmations),
                timestamp: Date(timeIntervalSince1970: TimeInterval($0.timeStamp)),
                fees: Int($0.totalFees),
                destinationAdresses: $0.destAddresses.map { BTCAddress(address: $0) }
            )
        }
    }
    
    func map(newAddressResponse response: Lnrpc_NewAddressResponse) -> BTCAddress {
        return BTCAddress(address: response.address)
    }
    
    func map(sendCoinsResponse response: Lnrpc_SendCoinsResponse) -> LNSTransactionId {
        return response.txid
    }
}
