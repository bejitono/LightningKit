//
//  LNSChannelServiceImplementation.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 25.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

final class LNSChannelServiceImplementation: LNSChannelService {
    
    private let client: LndClient
    private let mapper: LNSChannelMapper
    
    init(client: LndClient,
         mapper: LNSChannelMapper) {
        self.client = client
        self.mapper = mapper
    }
    
    func openChannel(withConfig config: LNSOpenChannelConfiguration, completion: @escaping LNSOpenChannelCompletion) {
        client.request(mapper.mapOpenChannelRequest(withConfig: config), map: mapper.map(openChannelResponse:), completion: completion)
    }
    
    func closeChannel(withConfig config: LNSCloseChannelConfiguration, completion: @escaping LNSCloseChannelCompletion) {
        client.request(mapper.mapCloseChannelRequest(withConfig: config), map: mapper.map(closeChannelResponse:), completion: completion)
    }
    
    func listChannels(completion: @escaping LNSListChannelCompletion) {
        client.request(mapper.mapListChannelsRequest(), map: mapper.map(listChannelsResponse:), completion: completion)
    }
    
    func listPendingChannels(completion: @escaping LNSListPendingChannelCompletion) {
        client.request(mapper.mapPendingChannelsRequest(), map: mapper.map(pendingChannelsResponse:), completion: completion)
    }
}
