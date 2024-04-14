//
//  GenshinRoleSkillModel.swift
//  MiTool
//
//  Created by Cain on 2024/3/25.
//

import Foundation
import ObjectMapper


// GenshinRoleSkillDataModel
public struct GenshinRoleSkillModel: MihoyoModelProtocol {
    public var message: String = ""
    public var retcode: Int = 0
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
    
    init(
        skillList: [GenshinRoleSkillItemModel]? = nil,
        weapon: GenshinRoleWeaponModel? = nil,
        reliquaryList: [GenshinRoleReliquaryModel]? = nil
    ) {
        self.skillList = skillList
        self.weapon = weapon
        self.reliquaryList = reliquaryList
    }
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        skillList <- map["skill_list"]
        weapon <- map["weapon"]
        reliquaryList <- map["reliquary_list"]
    }
}

// GenshinRoleSkillItemModel
public struct GenshinRoleSkillItemModel: Mappable, Identifiable {
    public var id = UUID()
    public var skillID: Int?
    public var groupID: Int?
    public var name: String?
    public var icon: String?
    public var maxLevel: Int = 90
    public var currentLevel: Int = 1
    public var roleID: Int?
    
    public var level: String {
        "Lv: \(currentLevel)"
    }
    
    public var skillURL: String {
        icon ?? ""
    }
    
    public init?(map: Map) {}
    
    init(
        roleID: Int?,
        skillID: Int?,
        groupID: Int?,
        name: String?,
        icon: String?,
        maxLevel: Int = 90
    ) {
        self.roleID = roleID
        self.skillID = skillID
        self.groupID = groupID
        self.name = name
        self.icon = icon
        self.maxLevel = maxLevel
    }
    
    mutating public func mapping(map: Map) {
        skillID <- map["id"]
        groupID <- map["group_id"]
        name <- map["name"]
        icon <- map["icon"]
        maxLevel <- map["max_level"]
        currentLevel <- map["level_current"]
    }
}

// GenshinRoleWeaponModel
public struct GenshinRoleWeaponModel: Mappable {
    public var id: Int?
    public var name: String = ""
    public var icon: String = ""
    public var weaponCatId: Int = 0
    public var weaponLevel: RarityType = .one
    public var maxLevel: Int = 90
    public var currentLevel: Int = 1
    
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
public struct GenshinRoleReliquaryModel: MihoyoDataModelProtocol {
    public var id = UUID()
    public var reliquaryID: Int?
    public var name: String = ""
    public var icon: String = ""
    public var reliquaryCatId: Int?
    public var reliquaryLevel: RarityType = .one
    public var currentLevel: Int = 1
    public var maxLevel: Int = 20
    
    public init?(map: Map) {}
    
    mutating public func mapping(map: Map) {
        reliquaryID <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        reliquaryCatId <- map["reliquary_cat_id"]
        reliquaryLevel <- map["reliquary_level"]
        currentLevel <- map["level_current"]
        maxLevel <- map["max_level"]
    }
}

extension GenshinRoleReliquaryModel {
    public var levelString: String {
        "Lv: \(currentLevel)"
    }
}
