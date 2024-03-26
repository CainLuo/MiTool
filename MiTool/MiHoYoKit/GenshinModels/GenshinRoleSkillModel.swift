//
//  GenshinRoleSkillModel.swift
//  MiTool
//
//  Created by Cain on 2024/3/25.
//

import Foundation
import ObjectMapper


// GenshinRoleSkillDataModel
public struct GenshinRoleSkillModel: Mappable {
    public var message: String?
    public var retcode: Int?
    public var data: GenshinRoleSkillDataModel?
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        message <- map["message"]
        retcode <- map["retcode"]
        data <- map["data"]
    }
}

// GenshinRoleSkillDataModel
public struct GenshinRoleSkillDataModel: Mappable {
    public var skillList: [GenshinRoleSkillItemModel]?
    public var weapon: GenshinRoleWeaponModel?
    public var reliquaryList: [GenshinRoleReliquaryModel]?
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        skillList <- map["skill_list"]
        weapon <- map["weapon"]
        reliquaryList <- map["reliquary_list"]
    }
}

// GenshinRoleSkillItemModel
public struct GenshinRoleSkillItemModel: Mappable {
    public var id: Int?
    public var groupId: Int?
    public var name: String?
    public var icon: String?
    public var maxLevel: Int?
    public var currentLevel: Int?
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        id <- map["id"]
        groupId <- map["group_id"]
        name <- map["name"]
        icon <- map["icon"]
        maxLevel <- map["max_level"]
        currentLevel <- map["level_current"]
    }
}

// GenshinRoleWeaponModel
public struct GenshinRoleWeaponModel: Mappable {
    public var id: Int?
    public var name: String?
    public var icon: String?
    public var weaponCatId: Int?
    public var weaponLevel: Int?
    public var maxLevel: Int?
    public var currentLevel: Int?
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
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
public struct GenshinRoleReliquaryModel: Mappable {
    public var id: Int?
    public var name: String?
    public var icon: String?
    public var reliquaryCatId: Int?
    public var reliquaryLevel: Int?
    public var currentLevel: Int?
    public var maxLevel: Int?
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        reliquaryCatId <- map["reliquary_cat_id"]
        reliquaryLevel <- map["reliquary_level"]
        currentLevel <- map["level_current"]
        maxLevel <- map["max_level"]
    }
}
