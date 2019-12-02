//
//  MutedUserRealmObject.swift
//  StreamChatRealm
//
//  Created by Alexey Bukhtin on 20/11/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import Foundation
import RealmSwift
import StreamChatCore

public final class MutedUserRealmObject: Object {
    
    @objc dynamic var id = ""
    @objc dynamic var user: UserRealmObject?
    @objc dynamic var created = Date.default
    @objc dynamic var updated = Date.default
    
    override public static func primaryKey() -> String? {
        return "id"
    }
    
    public var asMutedUser: MutedUser? {
        guard let user = user?.asUser else {
            return nil
        }
        
        return MutedUser(user: user, created: created, updated: updated)
    }
    
    required init() {
        super.init()
    }
    
    public init(mutedUser: MutedUser, channel: Channel) {
        id = "\(channel.cid)_\(mutedUser.user.id)"
        user = UserRealmObject(mutedUser.user)
        created = mutedUser.created
        updated = mutedUser.updated
    }
}