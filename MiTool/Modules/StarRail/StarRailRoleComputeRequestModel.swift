//
//  StarRailRoleComputeRequestModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/6.
//

import Foundation
import ObjectMapper

struct StarRailRoleComputeRequestModel: Mappable {
    var game: String = "hkrpg"
    var lang: String?
    var uid: String?
    var region: String?
    var avatar: StarRailRoleComputeRequestAvatarModel?
    var equipment: StarRailRoleComputeRequestAvatarModel?
    var skillList: [StarRailRoleComputeRequestSkillModel] = []

    init?(map: Map) {}
    init() { }

    mutating func mapping(map: Map) {
        game <- map["game"]
        avatar <- map["avatar"]
        equipment <- map["equipment"]
        skillList <- map["skill_list"]
        lang <- map["lang"]
        uid <- map["uid"]
        region <- map["region"]
    }
}

struct StarRailRoleComputeRequestAvatarModel: Mappable {
    var itemId: String?
    var curLevel: Int?
    var targetLevel: Int?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        itemId <- map["item_id"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
    }
}

struct StarRailRoleComputeRequestSkillModel: Mappable {
    var itemId: String?
    var curLevel: Int?
    var targetLevel: Int?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        itemId <- map["item_id"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
    }
}
