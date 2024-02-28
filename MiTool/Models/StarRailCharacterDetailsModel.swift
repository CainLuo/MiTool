//
//  StarRailCharacterDetailsModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/28.
//

import Foundation
import ObjectMapper

// MARK: - StarRailCharacterDetailsModel
struct StarRailCharacterDetailsModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: StarRailCharacterDetailsData?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailCharacterDetailsData
struct StarRailCharacterDetailsData: Mappable {
    var avatarList: [StarRailCharacterDetailsAvatarList]?
    var equipWiki: StarRailCharacterDetailsEquipWiki?
    var relicWiki: StarRailCharacterDetailsRelicWiki?
    var propertyInfo: StarRailCharacterDetailsPropertyInfo?
    var recommendProperty: StarRailCharacterDetailsRecommendProperty?
    var relicProperties: [StarRailCharacterDetailsRelicProperty]?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        avatarList <- map["avatar_list"]
        equipWiki <- map["equip_wiki"]
        relicWiki <- map["relic_wiki"]
        propertyInfo <- map["property_info"]
        recommendProperty <- map["recommend_property"]
        relicProperties <- map["relic_properties"]
    }
}

// MARK: - StarRailCharacterDetailsAvatarList
struct StarRailCharacterDetailsAvatarList: Mappable {
    var id: Int = 0
    var level: Int = 1
    var name: String = ""
    var element: String = ""
    var icon: String = ""
    var rarity: RarityType = .one
    var rank: Int = 0
    var image: String = ""
    var equip: StarRailCharacterDetailsEquip?
    var relics: [StarRailCharacterDetailsOrnament]?
    var ornaments: [StarRailCharacterDetailsOrnament]?
    var ranks: [StarRailCharacterDetailsRank]?
    var properties: [StarRailCharacterDetailsPropertyElement]?
    var skills: [StarRailCharacterDetailsSkill]?
    var baseType: Int = 0
    var figurePath: String = ""
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
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

// MARK: - StarRailCharacterDetailsEquip
struct StarRailCharacterDetailsEquip: Mappable {
    var id: Int = 0
    var level: Int = 1
    var rank: Int = 0
    var name: String = ""
    var desc: String = ""
    var icon: String = ""
    var rarity: RarityType = .one
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        level <- map["level"]
        rank <- map["rank"]
        name <- map["name"]
        desc <- map["desc"]
        icon <- map["icon"]
        rarity <- map["rarity"]
    }
}

// MARK: - StarRailCharacterDetailsOrnament
struct StarRailCharacterDetailsOrnament: Mappable {
    var id: Int = 0
    var level: Int = 1
    var pos: Int = 0
    var name: String = ""
    var desc: String = ""
    var icon: String = ""
    var rarity: RarityType = .one
    var mainProperty: StarRailCharacterDetailsMainPropertyClass?
    var properties: [StarRailCharacterDetailsMainPropertyClass]?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
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

// MARK: - StarRailCharacterDetailsMainPropertyClass
struct StarRailCharacterDetailsMainPropertyClass: Mappable {
    var propertyType: Int?
    var value: String?
    var times: Int?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        value <- map["value"]
        times <- map["times"]
    }
}

// MARK: - StarRailCharacterDetailsPropertyElement
struct StarRailCharacterDetailsPropertyElement: Mappable {
    var propertyType: Int?
    var base: String?
    var add: String?
    var propertyFinal: String?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        base <- map["base"]
        add <- map["add"]
        propertyFinal <- map["property_final"]
    }
}

// MARK: - StarRailCharacterDetailsRank
struct StarRailCharacterDetailsRank: Mappable {
    var id: Int?
    var pos: Int?
    var name: String?
    var icon: String?
    var desc: String?
    var isUnlocked: Bool?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        pos <- map["pos"]
        name <- map["name"]
        icon <- map["icon"]
        desc <- map["desc"]
        isUnlocked <- map["is_unlocked"]
    }
}

// MARK: - StarRailCharacterDetailsSkill
struct StarRailCharacterDetailsSkill: Mappable {
    var pointID: String?
    var pointType: Int?
    var itemURL: String?
    var level: Int = 1
    var isActivated: Bool?
    var isRankWork: Bool?
    var prePoint: String?
    var anchor: String?
    var remake: String?
    var skillStages: [StarRailCharacterDetailsSkillStage]?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
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

// MARK: - StarRailCharacterDetailsSkillStage
struct StarRailCharacterDetailsSkillStage: Mappable {
    var desc: String?
    var name: String?
    var level: Int?
    var remake: String?
    var itemURL: String?
    var isActivated: Bool?
    var isRankWork: Bool?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        desc <- map["desc"]
        name <- map["name"]
        level <- map["level"]
        remake <- map["remake"]
        itemURL <- map["item_url"]
        isActivated <- map["is_activated"]
        isRankWork <- map["is_rank_work"]
    }
}

// MARK: - StarRailCharacterDetailsEquipWiki
struct StarRailCharacterDetailsEquipWiki {
    var the20004: String?
    var the21000: String?
    var the21001: String?
    var the21002: String?
    var the21004: String?
    var the21005: String?
    var the21006: String?
    var the21008: String?
    var the21011: String?
    var the21013: String?
    var the21014: String?
    var the21018: String?
    var the21020: String?
    var the21021: String?
    var the21024: String?
    var the21025: String?
    var the21026: String?
    var the21042: String?
    var the22000: String?
    var the23000: String?
    var the23002: String?
    var the23004: String?
    var the23009: String?
    var the23010: String?
    var the23012: String?
    var the23015: String?
    var the23018: String?
    var the23022: String?
    var the24000: String?
    var the24001: String?
    var the24002: String?
    var the24003: String?
}

// MARK: - StarRailCharacterDetailsPropertyInfo
struct StarRailCharacterDetailsPropertyInfo {
    var the1: StarRailCharacterDetailsThe1?
    var the2: StarRailCharacterDetailsThe1?
    var the3: StarRailCharacterDetailsThe1?
    var the4: StarRailCharacterDetailsThe1?
    var the5: StarRailCharacterDetailsThe1?
    var the6: StarRailCharacterDetailsThe1?
    var the7: StarRailCharacterDetailsThe1?
    var the8: StarRailCharacterDetailsThe1?
    var the9: StarRailCharacterDetailsThe1?
    var the10: StarRailCharacterDetailsThe1?
    var the11: StarRailCharacterDetailsThe1?
    var the12: StarRailCharacterDetailsThe1?
    var the13: StarRailCharacterDetailsThe1?
    var the14: StarRailCharacterDetailsThe1?
    var the15: StarRailCharacterDetailsThe1?
    var the16: StarRailCharacterDetailsThe1?
    var the17: StarRailCharacterDetailsThe1?
    var the18: StarRailCharacterDetailsThe1?
    var the19: StarRailCharacterDetailsThe1?
    var the20: StarRailCharacterDetailsThe1?
    var the21: StarRailCharacterDetailsThe1?
    var the22: StarRailCharacterDetailsThe1?
    var the23: StarRailCharacterDetailsThe1?
    var the24: StarRailCharacterDetailsThe1?
    var the25: StarRailCharacterDetailsThe1?
    var the26: StarRailCharacterDetailsThe1?
    var the27: StarRailCharacterDetailsThe1?
    var the28: StarRailCharacterDetailsThe1?
    var the29: StarRailCharacterDetailsThe1?
    var the30: StarRailCharacterDetailsThe1?
    var the31: StarRailCharacterDetailsThe1?
    var the32: StarRailCharacterDetailsThe1?
    var the33: StarRailCharacterDetailsThe1?
    var the34: StarRailCharacterDetailsThe1?
    var the35: StarRailCharacterDetailsThe1?
    var the36: StarRailCharacterDetailsThe1?
    var the37: StarRailCharacterDetailsThe1?
    var the38: StarRailCharacterDetailsThe1?
    var the39: StarRailCharacterDetailsThe1?
    var the40: StarRailCharacterDetailsThe1?
    var the41: StarRailCharacterDetailsThe1?
    var the42: StarRailCharacterDetailsThe1?
    var the43: StarRailCharacterDetailsThe1?
    var the51: StarRailCharacterDetailsThe1?
    var the52: StarRailCharacterDetailsThe1?
    var the53: StarRailCharacterDetailsThe1?
    var the54: StarRailCharacterDetailsThe1?
    var the55: StarRailCharacterDetailsThe1?
    var the56: StarRailCharacterDetailsThe1?
    var the57: StarRailCharacterDetailsThe1?
    var the58: StarRailCharacterDetailsThe1?
    var the59: StarRailCharacterDetailsThe1?
    var the60: StarRailCharacterDetailsThe1?
}

// MARK: - StarRailCharacterDetailsThe1
struct StarRailCharacterDetailsThe1: Mappable {
    var propertyType: Int?
    var name: String?
    var icon: String?
    var propertyNameRelic: String?
    var propertyNameFilter: String?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        name <- map["name"]
        icon <- map["icon"]
        propertyNameRelic <- map["property_name_relic"]
        propertyNameFilter <- map["property_name_filter"]
    }
}

// MARK: - StarRailCharacterDetailsRecommendProperty
struct StarRailCharacterDetailsRecommendProperty {
    var the1001: StarRailCharacterDetailsThe1001?
    var the1002: StarRailCharacterDetailsThe1001?
    var the1003: StarRailCharacterDetailsThe1001?
    var the1004: StarRailCharacterDetailsThe1001?
    var the1005: StarRailCharacterDetailsThe1001?
    var the1006: StarRailCharacterDetailsThe1001?
    var the1008: StarRailCharacterDetailsThe1001?
    var the1009: StarRailCharacterDetailsThe1001?
    var the1013: StarRailCharacterDetailsThe1001?
    var the1101: StarRailCharacterDetailsThe1001?
    var the1102: StarRailCharacterDetailsThe1001?
    var the1103: StarRailCharacterDetailsThe1001?
    var the1104: StarRailCharacterDetailsThe1001?
    var the1105: StarRailCharacterDetailsThe1001?
    var the1106: StarRailCharacterDetailsThe1001?
    var the1107: StarRailCharacterDetailsThe1001?
    var the1108: StarRailCharacterDetailsThe1001?
    var the1109: StarRailCharacterDetailsThe1001?
    var the1110: StarRailCharacterDetailsThe1001?
    var the1111: StarRailCharacterDetailsThe1001?
    var the1112: StarRailCharacterDetailsThe1001?
    var the1201: StarRailCharacterDetailsThe1001?
    var the1202: StarRailCharacterDetailsThe1001?
    var the1203: StarRailCharacterDetailsThe1001?
    var the1204: StarRailCharacterDetailsThe1001?
    var the1205: StarRailCharacterDetailsThe1001?
    var the1206: StarRailCharacterDetailsThe1001?
    var the1207: StarRailCharacterDetailsThe1001?
    var the1208: StarRailCharacterDetailsThe1001?
    var the1209: StarRailCharacterDetailsThe1001?
    var the1210: StarRailCharacterDetailsThe1001?
    var the1211: StarRailCharacterDetailsThe1001?
    var the1212: StarRailCharacterDetailsThe1001?
    var the1213: StarRailCharacterDetailsThe1001?
    var the1214: StarRailCharacterDetailsThe1001?
    var the1215: StarRailCharacterDetailsThe1001?
    var the1217: StarRailCharacterDetailsThe1001?
    var the1302: StarRailCharacterDetailsThe1001?
    var the1303: StarRailCharacterDetailsThe1001?
    var the1305: StarRailCharacterDetailsThe1001?
    var the1306: StarRailCharacterDetailsThe1001?
    var the1307: StarRailCharacterDetailsThe1001?
    var the1312: StarRailCharacterDetailsThe1001?
    var the8001: StarRailCharacterDetailsThe1001?
    var the8002: StarRailCharacterDetailsThe1001?
    var the8003: StarRailCharacterDetailsThe1001?
    var the8004: StarRailCharacterDetailsThe1001?
}

// MARK: - StarRailCharacterDetailsThe1001
struct StarRailCharacterDetailsThe1001: Mappable {
    var recommendRelicProperties: [Int]?
    var customRelicProperties: [Any?]?
    var isCustomPropertyValid: Bool?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        recommendRelicProperties <- map["recommend_relic_properties"]
        customRelicProperties <- map["custom_relic_properties"]
        isCustomPropertyValid <- map["is_custom_property_valid"]
    }
}

// MARK: - StarRailCharacterDetailsRelicProperty
struct StarRailCharacterDetailsRelicProperty: Mappable {
    var propertyType: Int?
    var modifyPropertyType: Int?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        modifyPropertyType <- map["modify_property_type"]
    }
}

// MARK: - StarRailCharacterDetailsRelicWiki
struct StarRailCharacterDetailsRelicWiki {
}
