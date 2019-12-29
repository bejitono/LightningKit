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
        client.request(mapper.requestOpenChannel(withConfig: config), map: mapper.map(openChannelResponse:), completion: completion)
    }
    
    func listChannels(completion: @escaping LNSListChannelCompletion) {
        client.request(mapper.requestListChannels(), map: mapper.map(listChannelsResponse:), completion: completion)
    }
}
