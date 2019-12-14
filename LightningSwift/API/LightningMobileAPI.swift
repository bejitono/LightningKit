//
//  LightningMobileAPI.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Lndmobile
import SwiftProtobuf

final class LightningMobileAPI: LightningAPI {

    func call<Request, Response>(
        request: Request,
        completion: @escaping ((Result<Response, Error>) -> Void)
    ) throws where Request: SwiftProtobuf.Message, Response: SwiftProtobuf.Message {
        try? request.send(completion: completion)
    }
}

private extension SwiftProtobuf.Message {
    
    func send<Response>(completion: @escaping (Result<Response, Error>) -> Void) throws where Response: SwiftProtobuf.Message {
        switch self {
        case is Lnrpc_GenSeedRequest: LndmobileGenSeed(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_InitWalletRequest: LndmobileInitWallet(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_UnlockWalletRequest: LndmobileUnlockWallet(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChangePasswordRequest: LndmobileChangePassword(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_WalletBalanceRequest: LndmobileWalletBalance(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChannelBalanceRequest: LndmobileChannelBalance(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_GetTransactionsRequest: LndmobileGetTransactions(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_EstimateFeeRequest: LndmobileEstimateFee(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_SendCoinsRequest: LndmobileSendCoins(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ListUnspentRequest: LndmobileListUnspent(try? self.serializedData(), LightningCallback(completion))
        //case is Lnrpc_GetTransactionsRequest: LndmobileSubscribeTransactions(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_SendManyRequest: LndmobileSendMany(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_NewAddressRequest: LndmobileNewAddress(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_SignMessageRequest: LndmobileSignMessage(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_VerifyMessageRequest: LndmobileVerifyMessage(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ConnectPeerRequest: LndmobileConnectPeer(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_DisconnectPeerRequest: LndmobileDisconnectPeer(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ListPeersRequest: LndmobileListPeers(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_GetInfoRequest: LndmobileGetInfo(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_PendingChannelsRequest: LndmobilePendingChannels(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ListChannelsRequest: LndmobileListChannels(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChannelEventSubscription: LndmobileSubscribeChannelEvents(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ClosedChannelsRequest: LndmobileClosedChannels(try? self.serializedData(), LightningCallback(completion))
        //case is Lnrpc_OpenChannelRequest: LndmobileOpenChannelSync(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_OpenChannelRequest: LndmobileOpenChannel(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChannelAcceptRequest: LndmobileChannelAcceptor(LightningCallback(completion), nil)
        case is Lnrpc_CloseChannelRequest: LndmobileCloseChannel(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_AbandonChannelRequest: LndmobileAbandonChannel(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_SendRequest: LndmobileSendPayment(LightningCallback(completion), nil)
        //case is Lnrpc_SendRequest: LndmobileSendPaymentSync(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_SendToRouteRequest: LndmobileSendToRoute(LightningCallback(completion), nil)
        //case is Lnrpc_SendToRouteRequest: LndmobileSendToRouteSync(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_Invoice: LndmobileAddInvoice(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ListInvoiceRequest: LndmobileListInvoices(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_PaymentHash: LndmobileLookupInvoice(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_InvoiceSubscription: LndmobileSubscribeInvoices(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_PayReqString: LndmobileDecodePayReq(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ListPaymentsRequest: LndmobileListPayments(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_DeleteAllPaymentsRequest: LndmobileDeleteAllPayments(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChannelGraphRequest: LndmobileDescribeGraph(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChanInfoRequest: LndmobileGetChanInfo(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_NodeInfoRequest: LndmobileGetNodeInfo(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_QueryRoutesRequest: LndmobileQueryRoutes(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_NetworkInfoRequest: LndmobileGetNetworkInfo(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_StopRequest: LndmobileStopDaemon(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_GraphTopologySubscription: LndmobileSubscribeChannelGraph(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_DebugLevelRequest: LndmobileDebugLevel(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_FeeReportRequest: LndmobileFeeReport(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_PolicyUpdateRequest: LndmobileUpdateChannelPolicy(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ForwardingHistoryRequest: LndmobileForwardingHistory(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ExportChannelBackupRequest: LndmobileExportChannelBackup(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChanBackupExportRequest: LndmobileExportAllChannelBackups(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChanBackupSnapshot: LndmobileVerifyChanBackup(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_RestoreChanBackupRequest: LndmobileRestoreChannelBackups(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ChannelBackupSubscription: LndmobileSubscribeChannelBackups(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_BakeMacaroonRequest: LndmobileBakeMacaroon(try? self.serializedData(), LightningCallback(completion))
        case is Lnrpc_ListPeersRequest: LndmobileListPeers(try? self.serializedData(), LightningCallback(completion))
        default: throw LNSError.requestUnkown
        }
    }
}
