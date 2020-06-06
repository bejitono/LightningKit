//
//  LNSChannelServiceImplementation.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 25.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

final class LNSChannelServiceImplementation: LNSChannelService {
    
    private let client: LndClient
    
    init(client: LndClient) {
        self.client = client
    }
    
    func openChannel(withConfig config: LNSOpenChannelConfiguration, completion: @escaping LNSOpenChannelCompletion) {
        client.request(Lnrpc_OpenChannelRequest(config: config), map: LNSChannelPoint.init, completion: completion)
    }
    
    func closeChannel(withConfig config: LNSCloseChannelConfiguration, completion: @escaping LNSCloseChannelCompletion) {
        client.request(Lnrpc_CloseChannelRequest(config: config), map: LNSCloseChannelStatusUpdate.init, completion: completion)
    }
    
    func listChannels(completion: @escaping LNSListChannelCompletion) {
        client.request(Lnrpc_ListChannelsRequest(), map: Array.init(channelsResponse:), completion: completion)
    }
    
    func listPendingChannels(completion: @escaping LNSListPendingChannelCompletion) {
        client.request(Lnrpc_PendingChannelsRequest(), map: LNSPendingChannels.init, completion: completion)
    }
}
