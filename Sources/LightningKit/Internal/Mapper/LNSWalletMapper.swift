//
//  WalletMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 20.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate
import LightningKitClient

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
        self.init(
            phrase: response.cipherSeedMnemonic,
            encipheredSeed: response.encipheredSeed
        )
    }
}

extension Bool {
    
    init(initWalletResponse: Lnrpc_InitWalletResponse) {
        self = true
    }
    
    init(unlockWalletResponse: Lnrpc_UnlockWalletResponse) {
        self = true
    }
    
    init(changePasswordResponse: Lnrpc_ChangePasswordResponse) {
        self = true
    }
}

extension LNSWalletBalance {
    
    init(response: Lnrpc_WalletBalanceResponse) {
        self.init(
            totalBalance: Int(response.totalBalance),
            confirmedBalance: Int(response.confirmedBalance),
            unconfirmedBalance: Int(response.unconfirmedBalance)
        )
    }
}

extension LNSChannelBalance {
    
    init(response: Lnrpc_ChannelBalanceResponse) {
        self.init(
            balance: Int(response.balance),
            pendingBalance: Int(response.pendingOpenBalance)
        )
    }
}

extension Array where Element == LNSTransaction {
    
    init(transactionDetails: Lnrpc_TransactionDetails) {
        self = transactionDetails.transactions.map {
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
}

extension BTCAddress {
    
    init(response: Lnrpc_NewAddressResponse) {
        self = .init(address: response.address)
    }
}

extension LNSTransactionId {
    
    init(response: Lnrpc_SendCoinsResponse) {
        self = response.txid
    }
}
