//
//  GenshinRoleSkillModel.swift
//  MiTool
//
//  Created by Cain on 2024/3/25.
//

import Foundation
import ObjectMapper


// GenshinRoleSkillDataModel
struct GenshinRoleSkillModel: Mappable {
    var message: String?
    var retcode: Int?
    var data: GenshinRoleSkillDataModel?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        retcode <- map["retcode"]
        data <- map["data"]
    }
}

// GenshinRoleSkillDataModel
struct GenshinRoleSkillDataModel: Mappable {
    var skillList: [GenshinRoleSkillItemModel]?
    var weapon: GenshinRoleWeaponModel?
    var reliquaryList: [GenshinRoleReliquaryModel]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        skillList <- map["skill_list"]
        weapon <- map["weapon"]
        reliquaryList <- map["reliquary_list"]
    }
}

// GenshinRoleSkillItemModel
struct GenshinRoleSkillItemModel: Mappable {
    var id: Int?
    var groupId: Int?
    var name: String?
    var icon: String?
    var maxLevel: Int?
    var currentLevel: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        groupId <- map["group_id"]
        name <- map["name"]
        icon <- map["icon"]
        maxLevel <- map["max_level"]
        currentLevel <- map["level_current"]
    }
}

// GenshinRoleWeaponModel
struct GenshinRoleWeaponModel: Mappable {
    var id: Int?
    var name: String?
    var icon: String?
    var weaponCatId: Int?
    var weaponLevel: Int?
    var maxLevel: Int?
    var currentLevel: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        weaponCatId <- map["weapon_cat_id"]
        weaponLevel <- map["weapon_level"]
        maxLevel <- map["max_level"]
        currentLevel <- map["level_current"]
    }
}

// GenshinRoleReliquaryModel
struct GenshinRoleReliquaryModel: Mappable {
    var id: Int?
    var name: String?
    var icon: String?
    var reliquaryCatId: Int?
    var reliquaryLevel: Int?
    var currentLevel: Int?
    var maxLevel: Int?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        reliquaryCatId <- map["reliquary_cat_id"]
        reliquaryLevel <- map["reliquary_level"]
        currentLevel <- map["level_current"]
        maxLevel <- map["max_level"]
    }
}
