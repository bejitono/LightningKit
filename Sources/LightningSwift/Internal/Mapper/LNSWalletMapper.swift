//
//  WalletMapper.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 20.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation.NSDate

typealias LNSWalletMapper = LNSWalletRequestMapper & LNSWalletResponseMapper

protocol LNSWalletRequestMapper {
    
    func mapGenerateSeedRequest(withConfig config: LNSSeedConfiguration?) -> Lnrpc_GenSeedRequest
    
    func mapInitWalletRequestWith(password: String, seed: [String]) -> Lnrpc_InitWalletRequest
    
    func mapUnlockWalletRequest(withPassword password: String) -> Lnrpc_UnlockWalletRequest
    
    func mapChangeRequest(password: String, to newPassword: String) -> Lnrpc_ChangePasswordRequest
    
    func mapWalletBalanceRequest() -> Lnrpc_WalletBalanceRequest
    
    func mapChannelBalanceRequest() -> Lnrpc_ChannelBalanceRequest
    
    func mapTransactionsRequest() -> Lnrpc_GetTransactionsRequest
    
    func mapNewAddressRequest(forType type: LNSAddressType?) -> Lnrpc_NewAddressRequest
    
    func mapSendCoinsRequest(withConfig config: LNSSendCoinsConfiguration) -> Lnrpc_SendCoinsRequest
}

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

struct LNSWalletMapperImplementation: LNSWalletRequestMapper {
    
    func mapGenerateSeedRequest(withConfig config: LNSSeedConfiguration?) -> Lnrpc_GenSeedRequest {
        var req = Lnrpc_GenSeedRequest()
        guard let config = config else { return req }
        req.aezeedPassphrase = config.passphrase
        req.seedEntropy = config.entropy
        return req
    }
    
    func mapInitWalletRequestWith(password: String, seed: [String]) -> Lnrpc_InitWalletRequest {
        var req = Lnrpc_InitWalletRequest()
        guard let passwordData = password.data(using: .utf8) else { return req }
        req.walletPassword = passwordData
        req.cipherSeedMnemonic = seed
        // TODO: getting error "invalid passphrase"
        //if let encipheredSeed = seed.encipheredSeed { req.aezeedPassphrase = encipheredSeed }
        return req
    }
    
    func mapChangeRequest(password: String, to newPassword: String) -> Lnrpc_ChangePasswordRequest {
        var req = Lnrpc_ChangePasswordRequest()
        guard
            let passwordData = password.data(using: .utf8),
            let newPasswordData = newPassword .data(using: .utf8)
        else { return req }
        req.currentPassword = passwordData
        req.newPassword = newPasswordData
        return req
    }
    
    func mapUnlockWalletRequest(withPassword password: String) -> Lnrpc_UnlockWalletRequest {
        var req = Lnrpc_UnlockWalletRequest()
        guard let passwordData = password.data(using: .utf8) else { return req }
        req.walletPassword = passwordData
        return req
    }
    
    func mapWalletBalanceRequest() -> Lnrpc_WalletBalanceRequest {
        return Lnrpc_WalletBalanceRequest()
    }
    
    func mapChannelBalanceRequest() -> Lnrpc_ChannelBalanceRequest {
        return Lnrpc_ChannelBalanceRequest()
    }
    
    func mapTransactionsRequest() -> Lnrpc_GetTransactionsRequest {
        return Lnrpc_GetTransactionsRequest()
    }
    
    func mapNewAddressRequest(forType type: LNSAddressType?) -> Lnrpc_NewAddressRequest {
        var req = Lnrpc_NewAddressRequest()
        guard let type = type else { return req }
        req.type = type.lndAddressType
        return req
    }
    
    func mapSendCoinsRequest(withConfig config: LNSSendCoinsConfiguration) -> Lnrpc_SendCoinsRequest {
        var req = Lnrpc_SendCoinsRequest()
        req.addr = config.address
        req.amount = Int64(config.amount)
        req.targetConf = Int32(config.targetConfirmations)
        req.sendAll = config.sendAll
        return req
    }
}

extension LNSWalletMapperImplementation: LNSWalletResponseMapper {
    
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
