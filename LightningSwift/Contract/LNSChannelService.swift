//
//  LNSChannel.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSOpenChannelCompletion = (Result<LNSChannelPoint, Error>) -> Void
public typealias LNSCloseChannelCompletion = (Result<LNSCloseChannelStatusUpdate, Error>) -> Void
public typealias LNSListChannelCompletion = (Result<[LNSChannel], Error>) -> Void

public protocol LNSChannelService {
    
    func openChannel(withConfig config: LNSOpenChannelConfiguration, completion: @escaping LNSOpenChannelCompletion)
    
    func closeChannel(withConfig config: LNSCloseChannelConfiguration, completion: @escaping LNSCloseChannelCompletion)
    
    func listChannels(completion: @escaping LNSListChannelCompletion)
}
