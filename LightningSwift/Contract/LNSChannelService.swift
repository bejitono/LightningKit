//
//  LNSChannel.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 15.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

public typealias LNSOpenChannelCompletion = (Result<LNSChannelPoint, Error>) -> Void

public protocol LNSChannelService {
    
    func openChannel(withConfig config: LNSOpenChannelConfiguration, completion: @escaping LNSOpenChannelCompletion)
}
