//
//  StarRailRoleInfoModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/25.
//

import Foundation
import ObjectMapper

// MARK: - StarRailRoleInfoModel
public struct StarRailRoleInfoModel: MihoyoModelProtocol {
    public var retcode: Int = 0
    public var message: String = ""
    public var data: StarRailRoleInfoData?

    public init?(map: ObjectMapper.Map) { }
    public init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailRoleInfoData
public struct StarRailRoleInfoData: MihoyoDataModelProtocol {
    public var id = UUID()
    public var avatar: StarRailRoleInfoAvatar?
    public var skills: [StarRailRoleInfoSkill] = []
    public var skillsOther: [StarRailRoleInfoSkill] = []
    public var equipment: StarRailRoleInfoEquipment?
    public var isLogin: Bool?

    public init?(map: ObjectMapper.Map) { }
    public init() { }

    public init(
        avatar: String?,
        skills: String?,
        skillsOther: String?,
        equipment: String?,
        isLogin: Bool?
    ) {
        self.avatar = StarRailRoleInfoAvatar(JSONString: avatar ?? "")
        self.skills = [StarRailRoleInfoSkill](JSONString: skills ?? "") ?? []
        self.skillsOther = [StarRailRoleInfoSkill](JSONString: skillsOther ?? "") ?? []
        self.equipment = StarRailRoleInfoEquipment(JSONString: equipment ?? "")
        self.isLogin = isLogin
    }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatar <- map["avatar"]
        skills <- map["skills"]
        skillsOther <- map["skills_other"]
        equipment <- map["equipment"]
        isLogin <- map["is_login"]
    }
}

// MARK: - StarRailRoleInfoAvatar
public struct StarRailRoleInfoAvatar: MihoyoDataModelProtocol {
    public var id = UUID()
    public var itemID: String?
    public var itemName: String?
    public var iconURL: String?
    public var damageType: StarRailDamageTypes?
    public var rarity: StarRailRarityTypes = .one
    public var avatarBaseType: StarRailDestinyTypes?
    public var maxLevel: Int = 80
    public var curLevel: Int = 1
    public var targetLevel: Int?
    public var verticalIconURL: String?
    public var isForward: Bool?
    public var isUp: Bool?

    public init?(map: ObjectMapper.Map) { }
    public init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        itemID <- map["item_id"]
        itemName <- map["item_name"]
        iconURL <- map["icon_url"]
        damageType <- map["damage_type"]
        rarity <- map["rarity"]
        avatarBaseType <- map["avatar_base_type"]
        maxLevel <- map["max_level"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
        verticalIconURL <- map["vertical_icon_url"]
        isForward <- map["is_forward"]
        isUp <- map["is_up"]
    }
}

// MARK: - StarRailRoleInfoEquipment
public struct StarRailRoleInfoEquipment: MihoyoDataModelProtocol {
    public var id = UUID()
    public var itemID: String?
    public var itemName: String?
    public var itemURL: String?
    public var avatarBaseType: String?
    public var rarity: StarRailRarityTypes = .one
    public var maxLevel: Int = 80
    public var curLevel: Int = 1
    public var targetLevel: Int = 80
    public var isForward = false

    public init?(map: ObjectMapper.Map) { }
    public init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        itemID <- map["item_id"]
        itemName <- map["item_name"]
        itemURL <- map["item_url"]
        avatarBaseType <- map["avatar_base_type"]
        rarity <- map["rarity"]
        maxLevel <- map["max_level"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
        isForward <- map["is_forward"]
    }
}

// MARK: - StarRailRoleInfoSkill
public struct StarRailRoleInfoSkill: MihoyoDataModelProtocol {
    public var id = UUID()
    public var pointID: String?
    public var prePoint: String?
    public var pointType: StarRailRolePointType?
    public var anchor: StarRailRoleAnchorType?
    public var itemURL: String?
    public var maxLevel: Int?
    public var curLevel: Int = 1
    public var targetLevel: Int?
    public var progress: StarRailRoleInfoProgress?
    public var minLevelLimit: Int?

    public init?(map: ObjectMapper.Map) { }
    public init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        pointID <- map["point_id"]
        prePoint <- map["pre_point"]
        pointType <- map["point_type"]
        anchor <- map["anchor"]
        itemURL <- map["item_url"]
        maxLevel <- map["max_level"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
        progress <- map["progress"]
        minLevelLimit <- map["min_level_limit"]
    }
}

public enum StarRailRolePointType: Int {
    case other = 1
    case main = 2
    case talent = 3
}

public enum StarRailRoleAnchorType: String {
    case one = "Point01"
    case two = "Point02"
    case three = "Point03"
    case four = "Point04"
}

public enum StarRailRoleInfoProgress: String {
    case canLearnButStillNotLearn = "CanLearnButStillNotLearn"
    case learned = "Learned"
}
