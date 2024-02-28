//
//  StarRailRoleInfoModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/25.
//

import Foundation
import ObjectMapper

// MARK: - StarRailRoleInfoModel
struct StarRailRoleInfoModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: StarRailRoleInfoData?

    init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailRoleInfoData
struct StarRailRoleInfoData: Mappable {
    var avatar: StarRailRoleInfoAvatar?
    var skills: [StarRailRoleInfoSkill] = []
    var skillsOther: [StarRailRoleInfoSkill] = []
    var equipment: StarRailRoleInfoEquipment?
    var isLogin: Bool?
    
    init?(map: ObjectMapper.Map) { }
    
    init(avatar: String?, 
         skills: String?,
         skillsOther: String?,
         equipment: String?, 
         isLogin: Bool?) {
        self.avatar = StarRailRoleInfoAvatar(JSONString: avatar ?? "")
        self.skills = [StarRailRoleInfoSkill](JSONString: skills ?? "") ?? []
        self.skillsOther = [StarRailRoleInfoSkill](JSONString: skillsOther ?? "") ?? []
        self.equipment = StarRailRoleInfoEquipment(JSONString: equipment ?? "")
        self.isLogin = isLogin
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        avatar <- map["avatar"]
        skills <- map["skills"]
        skillsOther <- map["skills_other"]
        equipment <- map["equipment"]
        isLogin <- map["is_login"]
    }
}

// MARK: - StarRailRoleInfoAvatar
struct StarRailRoleInfoAvatar: Mappable {
    var itemID: String?
    var itemName: String?
    var iconURL: String?
    var damageType: Damage?
    var rarity: RarityType = .one
    var avatarBaseType: Destiny?
    var maxLevel: Int = 80
    var curLevel: Int = 1
    var targetLevel: Int?
    var verticalIconURL: String?
    var isForward: Bool?
    var isUp: Bool?
    
    var level: String {
        "Lv.\(curLevel)/\(maxLevel)"
    }
    
    init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
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
struct StarRailRoleInfoEquipment: Mappable {
    var itemID: String?
    var itemName: String?
    var itemURL: String?
    var avatarBaseType: String?
    var rarity: RarityType = .one
    var maxLevel: Int = 80
    var curLevel: Int = 1
    var targetLevel: Int?
    var isForward: Bool?
    
    var levelString: String {
        "Lv.\(curLevel)/\(maxLevel)"
    }
    
    init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
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
struct StarRailRoleInfoSkill: Mappable, Identifiable {
    var id = UUID()
    var pointID: String?
    var prePoint: String?
    var pointType: StarRailRoleInfoPointType?
    var anchor: String?
    var itemURL: String?
    var maxLevel: Int?
    var curLevel: Int?
    var targetLevel: Int?
    var progress: StarRailRoleInfoProgress?
    var minLevelLimit: Int?
    
    var skillLevel: String {
        guard let curLevel = curLevel, 
              let maxLevel = maxLevel else {
            return "Lv.1/-"
        }
        return "Lv.\(curLevel)/\(maxLevel)"
    }
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
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

enum StarRailRoleInfoPointType: Int {
    case other = 1
    case main = 2
    case talent = 3
}

enum StarRailRoleInfoProgress: String {
    case canLearnButStillNotLearn = "CanLearnButStillNotLearn"
    case learned = "Learned"
}
