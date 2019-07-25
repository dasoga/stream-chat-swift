//
//  WebSocket+Reconnect.swift
//  StreamChatCore
//
//  Created by Alexey Bukhtin on 30/04/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import Foundation
import Reachability
import Starscream

// MARK: - WebSocket Error

extension WebSocket {
    struct ErrorContainer: Decodable {
        let error: Error
    }
    
    struct Error: Decodable {
        private enum CodingKeys: String, CodingKey {
            case code
            case message
            case statusCode = "StatusCode"
        }
        
        let code: Int
        let message: String
        let statusCode: Int
    }
}

extension WebSocket {
    
    func willReconnectAfterError(_ error: Swift.Error) -> Bool {
        if let lastJSONError = lastJSONError, lastJSONError.code == 1000 {
            return false
        }
        
        if let wsError = error as? WSError, wsError.code == 1000 {
            return false
        }
        
        if InternetConnection.shared.isAvailable {
            reconnect()
            return true
        }
        
        return false
    }
    
    func reconnect() {
        guard !isReconnecting else {
            return
        }
        
        let delay = delayForReconnect
        logger?.log("⏳", "Reconnect in \(delay) sec")
        isReconnecting = true
        
        webSocket.callbackQueue.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.isReconnecting = false
            self?.connect()
        }
    }
    
    private var delayForReconnect: TimeInterval {
        let maxDelay: TimeInterval = min(500 + consecutiveFailures * 2000, 25000) / 1000
        let minDelay: TimeInterval = min(max(250, (consecutiveFailures - 1) * 2000), 25000) / 1000
        return minDelay + TimeInterval.random(in: 0...(maxDelay - minDelay))
    }
}
