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
struct MihoyoUserData {
    var userInfo: MihoyoUserInfo?

    init?(map: Map) { }

    mutating func mapping(map: ObjectMapper.Map) {
        userInfo <- map["user_info"]
    }
}

// MARK: - MihoyoUserInfo
struct MihoyoUserInfo {
    var uid: String?
    var nickname: String?
    var introduce: String?
    var gender: Int?
    var communityInfo: MihoyoUserCommunityInfo?
    var avatarURL: String?
    var ipRegion: String?
    var cookie: String?

    init?(map: Map) { }

    init(nickname: String, uid: String, cookie: String) {
        self.nickname = nickname
        self.uid = uid
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
struct MihoyoUserCommunityInfo {
    var createdAt: Int?

    init?(map: Map) { }

    mutating func mapping(map: ObjectMapper.Map) {
        createdAt <- map["created_at"]
    }
}

// MARK: - MihoyoUserListModel
struct MihoyoUserListModel: Identifiable, Hashable {
    var id = UUID()
    var uid: String = ""
    var nickname: String = ""
    var introduce: String = ""
    var gender: Int = 0
    var createdAt: Int = 0
    var avatarURL: String = ""
    var ipRegion: String = ""
    var cookie: String = ""

    var createTime: String {
        guard createdAt != 0 else {
            return ""
        }

        let date = Date(timeIntervalSince1970: TimeInterval(createdAt))
        let dateFormart = DateFormatter()
        dateFormart.dateFormat = CopyGenshinWeight.date
        return dateFormart.string(from: date)
    }
}
