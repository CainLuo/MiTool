//
//  StarRailSkillComputeRequestModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/26.
//

import Foundation
import ObjectMapper

// MARK: - StarRailSkillComputeRequestModel
struct StarRailSkillComputeRequestModel: Mappable {
    var game: String?
    var avatar: StarRailSkillComputeRequestAvatar?
    var equipment: StarRailSkillComputeRequestAvatar?
    var skillList: [StarRailSkillComputeRequestAvatar]?
    var lang: String?
    var uid: String?
    var region: String?
    
    init?(map: ObjectMapper.Map) { }
    
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        game <- map["game"]
        avatar <- map["avatar"]
        equipment <- map["equipment"]
        skillList <- map["skill_list"]
        lang <- map["lang"]
        uid <- map["uid"]
        region <- map["region"]
    }
}

// MARK: - StarRailSkillComputeRequestAvatar
struct StarRailSkillComputeRequestAvatar: Mappable {
    var itemID: String?
    var curLevel: Int?
    var targetLevel: Int?
    
    init?(map: ObjectMapper.Map) { }
    
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        itemID <- map["item_id"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
    }
}
