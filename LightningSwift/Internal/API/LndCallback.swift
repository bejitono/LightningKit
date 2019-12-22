//
//  LightningCallback.swift
//  LightningSwift
//
//  Created by De MicheliStefano on 09.12.19.
//  Copyright © 2019 De MicheliStefano. All rights reserved.
//

import Foundation
import Lndmobile
import SwiftProtobuf

final class LndCallback<Response: SwiftProtobuf.Message>: NSObject, LndmobileCallbackProtocol, LndmobileRecvStreamProtocol {
    
    private let completion: (Result<Response, Error>) -> Void

    init(_ completion: @escaping (Result<Response, Error>) -> Void) {
        self.completion = completion
    }

    func onError(_ error: Error?) {
        guard let error = error else {
            completion(.failure(LNSError.unknown))
            return
        }
        completion(.failure(error))
    }

    func onResponse(_ data: Data?) {
        guard let data = data, let result = try? Response(serializedData: data) else {
            completion(.success(Response()))
            return
        }
        completion(.success(result))
    }
}

final class LndEmptyCallback: NSObject, LndmobileCallbackProtocol {
    
    func onError(_ error: Error?) {
        guard let error = error else { return }
        print(error)
    }

    func onResponse(_ data: Data?) { }
}
