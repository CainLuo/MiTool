//
//  StarRailSkillComputeRequestModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/26.
//

import Foundation
import ObjectMapper

// MARK: - StarRailSkillComputeRequestModel
public struct StarRailSkillComputeRequestModel: Mappable {
    public var game: String?
    public var avatar: StarRailSkillComputeRequestAvatar?
    public var equipment: StarRailSkillComputeRequestAvatar?
    public var skillList: [StarRailSkillComputeRequestAvatar]?
    public var lang: String?
    public var uid: String?
    public var region: String?
    
    public init?(map: ObjectMapper.Map) { }
    
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
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
public struct StarRailSkillComputeRequestAvatar: Mappable {
    public var itemID: String?
    public var curLevel: Int?
    public var targetLevel: Int?
    
    public init?(map: ObjectMapper.Map) { }
    
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        itemID <- map["item_id"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
    }
}
