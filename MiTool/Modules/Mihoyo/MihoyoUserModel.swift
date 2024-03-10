//
//  MihoyoUserModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import Foundation
import ObjectMapper

// MARK: - MihoyoUserModel
struct MihoyoUserModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: MihoyoUserData?

    init?(map: Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - MihoyoUserData
struct MihoyoUserData: Mappable {
    var userInfo: MihoyoUserInfo?

    init?(map: Map) { }

    mutating func mapping(map: ObjectMapper.Map) {
        userInfo <- map["user_info"]
    }
}

// MARK: - MihoyoUserInfo
struct MihoyoUserInfo: Mappable, Identifiable {
    var id = UUID()
    var uid: String = ""
    var nickname: String = ""
    var introduce: String?
    var gender: Int?
    var communityInfo: MihoyoUserCommunityInfo?
    var avatarURL: String = ""
    var ipRegion: String = ""
    var cookie: String?

    init?(map: Map) { }
    init() { }

    var uidString: String {
        "UID: \(uid)"
    }

    var createdAt: Int {
        communityInfo?.createdAt ?? 0
    }

    var createTime: String {
        let date = Date(timeIntervalSince1970: TimeInterval(createdAt))
        let dateFormart = DateFormatter()
        dateFormart.dateFormat = CopyGenshinWeight.date
        return dateFormart.string(from: date)
    }
    
    init(
        uid: String,
        nickname: String,
        introduce: String? = nil,
        gender: Int? = nil,
        communityInfo: String? = nil,
        avatarURL: String? = nil,
        ipRegion: String? = nil,
        cookie: String
    ) {
        self.uid = uid
        self.nickname = nickname
        self.introduce = introduce
        self.gender = gender
        self.communityInfo = MihoyoUserCommunityInfo(JSONString: communityInfo ?? "")
        self.avatarURL = avatarURL ?? ""
        self.ipRegion = ipRegion ?? ""
        self.cookie = cookie
    }

    mutating func mapping(map: ObjectMapper.Map) {
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
struct MihoyoUserCommunityInfo: Mappable {
    var createdAt: Int?

    init?(map: Map) { }

    mutating func mapping(map: ObjectMapper.Map) {
        createdAt <- map["created_at"]
    }
}
