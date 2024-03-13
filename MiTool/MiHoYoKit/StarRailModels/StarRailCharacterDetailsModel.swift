//
//  StarRailChaDetailsModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/28.
//

import Foundation
import ObjectMapper

// MARK: - StarRailChaDetailsModel
public struct StarRailChaDetailsModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: StarRailChaDetailsData?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailChaDetailsData
public struct StarRailChaDetailsData: Mappable {
    public var avatarList: [StarRailChaDetailsAvatarList]?
    public var equipWiki: StarRailChaDetailsEquipWiki?
    public var relicWiki: StarRailChaDetailsRelicWiki?
    public var propertyInfo: StarRailChaDetailsPropertyInfo?
    public var recommendProperty: StarRailChaDetailsRecommendProperty?
    public var relicProperties: [StarRailChaDetailsRelicProperty]?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        avatarList <- map["avatar_list"]
        equipWiki <- map["equip_wiki"]
        relicWiki <- map["relic_wiki"]
        propertyInfo <- map["property_info"]
        recommendProperty <- map["recommend_property"]
        relicProperties <- map["relic_properties"]
    }
}

// MARK: - StarRailChaDetailsAvatarList
public struct StarRailChaDetailsAvatarList: Mappable {
    public var id: Int = 0
    public var level: Int = 1
    public var name: String = ""
    public var element: String = ""
    public var icon: String = ""
    public var rarity: RarityType = .one
    public var rank: Int = 0
    public var image: String = ""
    public var equip: StarRailChaDetailsEquip?
    public var relics: [StarRailChaDetailsOrnament]?
    public var ornaments: [StarRailChaDetailsOrnament]?
    public var ranks: [StarRailChaDetailsRank]?
    public var properties: [StarRailChaDetailsPropertyElement]?
    public var skills: [StarRailChaDetailsSkill]?
    public var baseType: Int = 0
    public var figurePath: String = ""
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        level <- map["level"]
        name <- map["name"]
        element <- map["element"]
        icon <- map["icon"]
        rarity <- map["rarity"]
        rank <- map["rank"]
        image <- map["image"]
        equip <- map["equip"]
        relics <- map["relics"]
        ornaments <- map["ornaments"]
        ranks <- map["ranks"]
        properties <- map["properties"]
        skills <- map["skills"]
        baseType <- map["baseType"]
        figurePath <- map["figurePath"]
    }
}

// MARK: - StarRailChaDetailsEquip
public struct StarRailChaDetailsEquip: Mappable {
    public var id: Int = 0
    public var level: Int = 1
    public var rank: Int = 0
    public var name: String = ""
    public var desc: String = ""
    public var icon: String = ""
    public var rarity: RarityType = .one
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        level <- map["level"]
        rank <- map["rank"]
        name <- map["name"]
        desc <- map["desc"]
        icon <- map["icon"]
        rarity <- map["rarity"]
    }
}

// MARK: - StarRailChaDetailsOrnament
public struct StarRailChaDetailsOrnament: Mappable {
    public var id: Int = 0
    public var level: Int = 1
    public var pos: Int = 0
    public var name: String = ""
    public var desc: String = ""
    public var icon: String = ""
    public var rarity: RarityType = .one
    public var mainProperty: StarRailChaDetailsMainPropertyClass?
    public var properties: [StarRailChaDetailsMainPropertyClass]?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        level <- map["level"]
        pos <- map["pos"]
        name <- map["name"]
        desc <- map["desc"]
        icon <- map["icon"]
        rarity <- map["rarity"]
        mainProperty <- map["main_property"]
        properties <- map["properties"]
    }
}

// MARK: - StarRailChaDetailsMainPropertyClass
public struct StarRailChaDetailsMainPropertyClass: Mappable {
    public var propertyType: Int?
    public var value: String?
    public var times: Int?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        value <- map["value"]
        times <- map["times"]
    }
}

// MARK: - StarRailChaDetailsPropertyElement
public struct StarRailChaDetailsPropertyElement: Mappable {
    public var propertyType: Int?
    public var base: String?
    public var add: String?
    public var propertyFinal: String?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        base <- map["base"]
        add <- map["add"]
        propertyFinal <- map["property_final"]
    }
}

// MARK: - StarRailChaDetailsRank
public struct StarRailChaDetailsRank: Mappable {
    public var id: Int?
    public var pos: Int?
    public var name: String?
    public var icon: String?
    public var desc: String?
    public var isUnlocked: Bool?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        pos <- map["pos"]
        name <- map["name"]
        icon <- map["icon"]
        desc <- map["desc"]
        isUnlocked <- map["is_unlocked"]
    }
}

// MARK: - StarRailChaDetailsSkill
public struct StarRailChaDetailsSkill: Mappable {
    public var pointID: String?
    public var pointType: Int?
    public var itemURL: String?
    public var level: Int = 1
    public var isActivated: Bool?
    public var isRankWork: Bool?
    public var prePoint: String?
    public var anchor: String?
    public var remake: String?
    public var skillStages: [StarRailChaDetailsSkillStage]?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        pointID <- map["point_id"]
        pointType <- map["point_type"]
        itemURL <- map["item_url"]
        level <- map["level"]
        isActivated <- map["is_activated"]
        isRankWork <- map["is_rank_work"]
        prePoint <- map["pre_point"]
        anchor <- map["anchor"]
        remake <- map["remake"]
        skillStages <- map["skill_stages"]
    }
}

// MARK: - StarRailChaDetailsSkillStage
public struct StarRailChaDetailsSkillStage: Mappable {
    public var desc: String?
    public var name: String?
    public var level: Int?
    public var remake: String?
    public var itemURL: String?
    public var isActivated: Bool?
    public var isRankWork: Bool?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        desc <- map["desc"]
        name <- map["name"]
        level <- map["level"]
        remake <- map["remake"]
        itemURL <- map["item_url"]
        isActivated <- map["is_activated"]
        isRankWork <- map["is_rank_work"]
    }
}

// MARK: - StarRailChaDetailsEquipWiki
public struct StarRailChaDetailsEquipWiki {
    public var the20004: String?
    public var the21000: String?
    public var the21001: String?
    public var the21002: String?
    public var the21004: String?
    public var the21005: String?
    public var the21006: String?
    public var the21008: String?
    public var the21011: String?
    public var the21013: String?
    public var the21014: String?
    public var the21018: String?
    public var the21020: String?
    public var the21021: String?
    public var the21024: String?
    public var the21025: String?
    public var the21026: String?
    public var the21042: String?
    public var the22000: String?
    public var the23000: String?
    public var the23002: String?
    public var the23004: String?
    public var the23009: String?
    public var the23010: String?
    public var the23012: String?
    public var the23015: String?
    public var the23018: String?
    public var the23022: String?
    public var the24000: String?
    public var the24001: String?
    public var the24002: String?
    public var the24003: String?
}

// MARK: - StarRailChaDetailsPropertyInfo
public struct StarRailChaDetailsPropertyInfo {
    public var the1: StarRailChaDetailsThe1?
    public var the2: StarRailChaDetailsThe1?
    public var the3: StarRailChaDetailsThe1?
    public var the4: StarRailChaDetailsThe1?
    public var the5: StarRailChaDetailsThe1?
    public var the6: StarRailChaDetailsThe1?
    public var the7: StarRailChaDetailsThe1?
    public var the8: StarRailChaDetailsThe1?
    public var the9: StarRailChaDetailsThe1?
    public var the10: StarRailChaDetailsThe1?
    public var the11: StarRailChaDetailsThe1?
    public var the12: StarRailChaDetailsThe1?
    public var the13: StarRailChaDetailsThe1?
    public var the14: StarRailChaDetailsThe1?
    public var the15: StarRailChaDetailsThe1?
    public var the16: StarRailChaDetailsThe1?
    public var the17: StarRailChaDetailsThe1?
    public var the18: StarRailChaDetailsThe1?
    public var the19: StarRailChaDetailsThe1?
    public var the20: StarRailChaDetailsThe1?
    public var the21: StarRailChaDetailsThe1?
    public var the22: StarRailChaDetailsThe1?
    public var the23: StarRailChaDetailsThe1?
    public var the24: StarRailChaDetailsThe1?
    public var the25: StarRailChaDetailsThe1?
    public var the26: StarRailChaDetailsThe1?
    public var the27: StarRailChaDetailsThe1?
    public var the28: StarRailChaDetailsThe1?
    public var the29: StarRailChaDetailsThe1?
    public var the30: StarRailChaDetailsThe1?
    public var the31: StarRailChaDetailsThe1?
    public var the32: StarRailChaDetailsThe1?
    public var the33: StarRailChaDetailsThe1?
    public var the34: StarRailChaDetailsThe1?
    public var the35: StarRailChaDetailsThe1?
    public var the36: StarRailChaDetailsThe1?
    public var the37: StarRailChaDetailsThe1?
    public var the38: StarRailChaDetailsThe1?
    public var the39: StarRailChaDetailsThe1?
    public var the40: StarRailChaDetailsThe1?
    public var the41: StarRailChaDetailsThe1?
    public var the42: StarRailChaDetailsThe1?
    public var the43: StarRailChaDetailsThe1?
    public var the51: StarRailChaDetailsThe1?
    public var the52: StarRailChaDetailsThe1?
    public var the53: StarRailChaDetailsThe1?
    public var the54: StarRailChaDetailsThe1?
    public var the55: StarRailChaDetailsThe1?
    public var the56: StarRailChaDetailsThe1?
    public var the57: StarRailChaDetailsThe1?
    public var the58: StarRailChaDetailsThe1?
    public var the59: StarRailChaDetailsThe1?
    public var the60: StarRailChaDetailsThe1?
}

// MARK: - StarRailChaDetailsThe1
public struct StarRailChaDetailsThe1: Mappable {
    public var propertyType: Int?
    public var name: String?
    public var icon: String?
    public var propertyNameRelic: String?
    public var propertyNameFilter: String?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        name <- map["name"]
        icon <- map["icon"]
        propertyNameRelic <- map["property_name_relic"]
        propertyNameFilter <- map["property_name_filter"]
    }
}

// MARK: - StarRailChaDetailsRecommendProperty
public struct StarRailChaDetailsRecommendProperty {
    public var the1001: StarRailChaDetailsThe1001?
    public var the1002: StarRailChaDetailsThe1001?
    public var the1003: StarRailChaDetailsThe1001?
    public var the1004: StarRailChaDetailsThe1001?
    public var the1005: StarRailChaDetailsThe1001?
    public var the1006: StarRailChaDetailsThe1001?
    public var the1008: StarRailChaDetailsThe1001?
    public var the1009: StarRailChaDetailsThe1001?
    public var the1013: StarRailChaDetailsThe1001?
    public var the1101: StarRailChaDetailsThe1001?
    public var the1102: StarRailChaDetailsThe1001?
    public var the1103: StarRailChaDetailsThe1001?
    public var the1104: StarRailChaDetailsThe1001?
    public var the1105: StarRailChaDetailsThe1001?
    public var the1106: StarRailChaDetailsThe1001?
    public var the1107: StarRailChaDetailsThe1001?
    public var the1108: StarRailChaDetailsThe1001?
    public var the1109: StarRailChaDetailsThe1001?
    public var the1110: StarRailChaDetailsThe1001?
    public var the1111: StarRailChaDetailsThe1001?
    public var the1112: StarRailChaDetailsThe1001?
    public var the1201: StarRailChaDetailsThe1001?
    public var the1202: StarRailChaDetailsThe1001?
    public var the1203: StarRailChaDetailsThe1001?
    public var the1204: StarRailChaDetailsThe1001?
    public var the1205: StarRailChaDetailsThe1001?
    public var the1206: StarRailChaDetailsThe1001?
    public var the1207: StarRailChaDetailsThe1001?
    public var the1208: StarRailChaDetailsThe1001?
    public var the1209: StarRailChaDetailsThe1001?
    public var the1210: StarRailChaDetailsThe1001?
    public var the1211: StarRailChaDetailsThe1001?
    public var the1212: StarRailChaDetailsThe1001?
    public var the1213: StarRailChaDetailsThe1001?
    public var the1214: StarRailChaDetailsThe1001?
    public var the1215: StarRailChaDetailsThe1001?
    public var the1217: StarRailChaDetailsThe1001?
    public var the1302: StarRailChaDetailsThe1001?
    public var the1303: StarRailChaDetailsThe1001?
    public var the1305: StarRailChaDetailsThe1001?
    public var the1306: StarRailChaDetailsThe1001?
    public var the1307: StarRailChaDetailsThe1001?
    public var the1312: StarRailChaDetailsThe1001?
    public var the8001: StarRailChaDetailsThe1001?
    public var the8002: StarRailChaDetailsThe1001?
    public var the8003: StarRailChaDetailsThe1001?
    public var the8004: StarRailChaDetailsThe1001?
}

// MARK: - StarRailChaDetailsThe1001
public struct StarRailChaDetailsThe1001: Mappable {
    public var recommendRelicProperties: [Int]?
    public var customRelicProperties: [Any?]?
    public var isCustomPropertyValid: Bool?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        recommendRelicProperties <- map["recommend_relic_properties"]
        customRelicProperties <- map["custom_relic_properties"]
        isCustomPropertyValid <- map["is_custom_property_valid"]
    }
}

// MARK: - StarRailChaDetailsRelicProperty
public struct StarRailChaDetailsRelicProperty: Mappable {
    public var propertyType: Int?
    public var modifyPropertyType: Int?
    
    public init?(map: Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        modifyPropertyType <- map["modify_property_type"]
    }
}

// MARK: - StarRailChaDetailsRelicWiki
public struct StarRailChaDetailsRelicWiki {
}
