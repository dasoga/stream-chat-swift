//
//  MessageViewStyle.swift
//  StreamChat
//
//  Created by Alexey Bukhtin on 05/04/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit

/// A composition of view styles.
public struct ChatViewStyle {
    
    /// A channel view style.
    public var channel: ChannelViewStyle
    /// A composer view style.
    public var composer: ComposerViewStyle
    /// An incoming message view style.
    public var incomingMessage: MessageViewStyle
    /// An outgoing message view style.
    public var outgoingMessage: MessageViewStyle
    
    /// The default chat view style.
    public static let `default` = ChatViewStyle()
    /// A dark chat view style.
    public static let dark =
        ChatViewStyle(channel: ChannelViewStyle(backgroundColor: .chatSuperDarkGray,
                                                nameColor: .chatGray,
                                                nameUnreadColor: .white,
                                                messageUnreadColor: .white),
                      composer: ComposerViewStyle(textColor: .white,
                                                  helperContainerBackgroundColor: .chatDarkGray,
                                                  states: [.active: .init(tintColor: .chatBlue, borderWidth: 2),
                                                           .edit: .init(tintColor: .chatGreen, borderWidth: 2),
                                                           .disabled: .init(tintColor: .chatGray, borderWidth: 2)]),
                      incomingMessage: MessageViewStyle(chatBackgroundColor: .chatSuperDarkGray,
                                                        textColor: .white,
                                                        backgroundColor: .chatSuperDarkGray,
                                                        borderColor: .chatGray,
                                                        reactionViewStyle: .init(backgroundColor: .darkGray,
                                                                                 chatBackgroundColor: .chatSuperDarkGray)),
                      outgoingMessage: MessageViewStyle(alignment: .right,
                                                        chatBackgroundColor: .chatSuperDarkGray,
                                                        textColor: .white,
                                                        backgroundColor: .chatDarkGray,
                                                        borderWidth: 0,
                                                        reactionViewStyle: .init(alignment: .right,
                                                                                 backgroundColor: .darkGray,
                                                                                 chatBackgroundColor: .chatSuperDarkGray)))
    
    /// Init a composition of view styles.
    ///
    /// - Parameters:
    ///   - channel: a channel view style.
    ///   - composer: a composer view style.
    ///   - incomingMessage: an incoming message view style.
    ///   - outgoingMessage: an outgoing message view style.
    public init(channel: ChannelViewStyle = .init(),
                composer: ComposerViewStyle = .init(),
                incomingMessage: MessageViewStyle = .init(),
                outgoingMessage: MessageViewStyle = .init(alignment: .right,
                                                          backgroundColor: .chatSuperLightGray,
                                                          borderWidth: 0,
                                                          reactionViewStyle: .init(alignment: .right))) {
        self.channel = channel
        self.composer = composer
        self.incomingMessage = incomingMessage
        self.outgoingMessage = outgoingMessage
    }
}

extension ChatViewStyle: Hashable {
    
    public static func == (lhs: ChatViewStyle, rhs: ChatViewStyle) -> Bool {
        return lhs.channel == rhs.channel
            && lhs.composer == rhs.composer
            && lhs.incomingMessage == rhs.incomingMessage
            && lhs.outgoingMessage == rhs.outgoingMessage
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(channel)
        hasher.combine(composer)
        hasher.combine(incomingMessage)
        hasher.combine(outgoingMessage)
    }
}

/// A chat style visibility type.
///
/// - always: show an element always visible, even if it disabled.
/// - whenActive: an element will be hidden until it will change own state to active.
public enum ChatViewStyleVisibility {
    case none
    case always
    case whenActive
}
