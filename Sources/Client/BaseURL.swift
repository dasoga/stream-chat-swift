//
//  BaseURL.swift
//  StreamChatCore
//
//  Created by Alexey Bukhtin on 01/04/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import Foundation

/// A base URL for the `Client`.
public struct BaseURL: CustomStringConvertible {
    static let placeholderURL = URL(string: "https://getstream.io")!
    
    public static let usEast = BaseURL(serverLocation: .usEast)
    public static let dublin = BaseURL(serverLocation: .dublin)
    
    public let baseURL: URL
    public let wsURL: URL
    
    public var description: String { return baseURL.absoluteString }
    
    /// Create a base URL.
    /// - Parameter serverLocation: a Stream Chat server location.
    init(serverLocation: ServerLocation = .usEast) {
        self.init(url: URL(string: serverLocation.rawValue)!)
    }
    
    /// Init with a custom server URL.
    ///
    /// - Parameter url: an URL
    init(url: URL) {
        var urlString = url.absoluteString
        
        // Remove a scheme prefix.
        for prefix in ["https:", "http:", "wss:", "ws:"] {
            if urlString.hasPrefix(prefix) {
                urlString = String(urlString.suffix(urlString.count - prefix.count))
                break
            }
        }
        
        urlString = urlString.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        baseURL = URL(string: "https://\(urlString)/")!
        wsURL = URL(string: "wss://\(urlString)/")!
    }
}

// MARK: - Base URL Location

extension BaseURL {
    /// A server location.
    public enum ServerLocation: String {
        /// US-East server.
        case usEast = "https://chat-proxy-us-east.stream-io-api.com/"
        /// Dublin server.
        case dublin = "https://chat-proxy-dublin.stream-io-api.com/"
    }
}
