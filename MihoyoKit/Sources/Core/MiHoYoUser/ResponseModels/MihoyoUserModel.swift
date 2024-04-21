//
//  MihoyoUserModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import Foundation
import ObjectMapper

// MARK: - MihoyoUserModel
public struct MihoyoUserModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: MihoyoUserData?

    public init?(map: Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - MihoyoUserData
public struct MihoyoUserData: Mappable {
    public var userInfo: MihoyoUserInfo?

    public init?(map: Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        userInfo <- map["user_info"]
    }
}

// MARK: - MihoyoUserInfo
public struct MihoyoUserInfo: Mappable, Identifiable {
    public var id = UUID()
    public var uid: String = ""
    public var nickname: String = ""
    public var introduce: String?
    public var gender: Int?
    public var communityInfo: MihoyoUserCommunityInfo?
    public var avatarURL: String = ""
    public var ipRegion: String = ""
    public var cookie: String?
    public var sToken: String?
    public var deivceFP: String?
    public var deviceID: String?
    public var region: String?
    public var cookieToken: String?

    public init?(map: Map) { }
    init() { }
    
    init(
        uid: String,
        nickname: String,
        introduce: String? = nil,
        gender: Int? = nil,
        communityInfo: String? = nil,
        avatarURL: String? = nil,
        ipRegion: String? = nil,
        cookie: String,
        sToken: String,
        deivceFP: String,
        deviceID: String,
        region: String,
        cookieToken: String
    ) {
        self.uid = uid
        self.nickname = nickname
        self.introduce = introduce
        self.gender = gender
        self.communityInfo = MihoyoUserCommunityInfo(JSONString: communityInfo ?? "")
        self.avatarURL = avatarURL ?? ""
        self.ipRegion = ipRegion ?? ""
        self.cookie = cookie
        self.sToken = sToken
        self.deivceFP = deivceFP
        self.deviceID = deviceID
        self.region = region
        self.cookieToken = cookieToken
    }

    mutating public func mapping(map: ObjectMapper.Map) {
        uid <- map["uid"]
        nickname <- map["nickname"]
        introduce <- map["introduce"]
        gender <- map["gender"]
        communityInfo <- map["community_info"]
        avatarURL <- map["avatar_url"]
        ipRegion <- map["ip_region"]
    }
}

// MARK: - MihoyoUserCommunityInfo
public struct MihoyoUserCommunityInfo: Mappable {
    public var createdAt: Int?

    public init?(map: Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        createdAt <- map["created_at"]
    }
}