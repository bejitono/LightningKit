//
//  LKChannel.swift
//  LightningKit
//
//  Created by De MicheliStefano on 07.06.20.
//  Copyright © 2020 De MicheliStefano. All rights reserved.
//

import LightningKitClient

open class LKChannel {
    
    public static var shared: LKChannel = LKChannel()
    public let ready: Bool = false
    
    private let client: LndClient

    public convenience init() { // TODO: Add config
        self.init(
            client: LndClientBuilder().build(for: .mobile)
        )
    }
    
    init(client: LndClient) {
        self.client = client
    }
    
    open func start(withConfig config: LNSConfiguration) {
        client.start(withConfig: config)
    }
    
    open func start() {
        client.start(withConfig: .defaultConfig)
    }

    /// Sends a shutdown request to the interrupt handler, triggering a graceful shutdown of the daemon.
    open func stop() {
        client.stop()
    }
    
    /// Returns a list of currently active peers.
    open func getPeers(completion: @escaping (Result<LNSInfo, Error>) -> Void) {
        // TODO
    }
    
    /// Returns general information concerning the lightning node.
    open func getInfo(completion: @escaping (Result<LNSInfo, Error>) -> Void) {
        client.request(Lnrpc_GetInfoRequest(), map: LNSInfo.init, completion: completion)
    }

    /// Attempts to add a new invoice to the invoice database. Any duplicated invoices are rejected,
    /// therefore all invoices must have a unique payment preimage.
    open func addInvoice(withRequest request: LNSInvoiceRequest, completion: @escaping (Result<LNSInvoice, Error>) -> Void) {
        client.request(Lnrpc_Invoice(request: request), map: LNSInvoice.init, completion: completion)
    }

    /// Attempts to route a payment described by the passed PaymentRequest to the final destination.
    open func sendPayment(withRequest request: LNSPaymentRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        client.request(Lnrpc_SendRequest(request: request), map: Bool.init(sendPaymentResponse:))  { result in
            switch result {
            case .success(_):
                completion(Result.success(()))
            case .failure(let error): completion(Result.failure(error))
            }
        }
    }
    
    /// Attempts to route a payment described by the passed PaymentRequest to the final destination.
    open func sendPayment(withRequest request: LNSEncodedPaymentRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        client.request(Lnrpc_SendRequest(request: request), map: Bool.init(sendPaymentResponse:))  { result in
            switch result {
            case .success(_):
                completion(Result.success(()))
            case .failure(let error): completion(Result.failure(error))
            }
        }
    }
    
    /// Returns a list of all outgoing payments.
    open func listPayments(withRequest request: LNSListPaymentsRequest = LNSListPaymentsRequest(), completion: @escaping (Result<[LNSPayment], Error>) -> Void) { // TODO: add request
        client.request(Lnrpc_ListPaymentsRequest(request: request), map: Array.init(listPayments:), completion: completion)
    }
    
    /// Returns a list of all the invoices currently stored within the database.
    open func listInvoices(withRequest request: LNSListInvoicesRequest = LNSListInvoicesRequest(), completion: @escaping (Result<[LNSInvoice], Error>) -> Void) {
        client.request(Lnrpc_ListInvoiceRequest(request: request), map: Array.init(listInvoice:), completion: completion)
    }
    
    /// Returns a list of currently active peers.
    open func connectPeer(withConfig config: LNSConnectPeerConfiguration, completion: @escaping (Result<Void, Error>) -> Void) {
        client.request(Lnrpc_ConnectPeerRequest(request: config), map: Bool.init(connectPeerResponse:))   { result in
            switch result {
            case .success(_):
                completion(Result.success(()))
            case .failure(let error): completion(Result.failure(error))
            }
        }
    }
    
    /// Attempts to open a singly funded channel specified in the request to a remote peer.
    open func openChannel(withConfig config: LNSOpenChannelConfiguration, completion: @escaping (Result<LNSChannelPoint, Error>) -> Void) {
        client.request(Lnrpc_OpenChannelRequest(config: config), map: LNSChannelPoint.init, completion: completion)
    }
    
    /// Attempts to close an active channel identified by its channel outpoint.
    open func closeChannel(withConfig config: LNSCloseChannelConfiguration, completion: @escaping (Result<LNSCloseChannelStatusUpdate, Error>) -> Void) {
        client.request(Lnrpc_CloseChannelRequest(config: config), map: LNSCloseChannelStatusUpdate.init, completion: completion)
    }
    
    /// Returns a description of all the open channels that this node is a participant in.
    open func listChannels(completion: @escaping (Result<[LNSChannel], Error>) -> Void) {
        client.request(Lnrpc_ListChannelsRequest(), map: Array.init(channelsResponse:), completion: completion)
    }
    
    open func listPendingChannels(completion: @escaping (Result<LNSPendingChannels, Error>) -> Void) {
        client.request(Lnrpc_PendingChannelsRequest(), map: LNSPendingChannels.init, completion: completion)
    }
    
    /// Returns the total funds available across all open channels in satoshis.
    open func getBalance(completion: @escaping (Result<LNSChannelBalance, Error>) -> Void) {
        client.request(Lnrpc_ChannelBalanceRequest(), map: LNSChannelBalance.init, completion: completion)
    }
}
