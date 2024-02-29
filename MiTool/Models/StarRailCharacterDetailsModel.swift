//
//  StarRailChaDetailsModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/28.
//

import Foundation
import ObjectMapper

// MARK: - StarRailChaDetailsModel
struct StarRailChaDetailsModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: StarRailChaDetailsData?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailChaDetailsData
struct StarRailChaDetailsData: Mappable {
    var avatarList: [StarRailChaDetailsAvatarList]?
    var equipWiki: StarRailChaDetailsEquipWiki?
    var relicWiki: StarRailChaDetailsRelicWiki?
    var propertyInfo: StarRailChaDetailsPropertyInfo?
    var recommendProperty: StarRailChaDetailsRecommendProperty?
    var relicProperties: [StarRailChaDetailsRelicProperty]?
    
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

// MARK: - StarRailChaDetailsAvatarList
struct StarRailChaDetailsAvatarList: Mappable {
    var id: Int = 0
    var level: Int = 1
    var name: String = ""
    var element: String = ""
    var icon: String = ""
    var rarity: RarityType = .one
    var rank: Int = 0
    var image: String = ""
    var equip: StarRailChaDetailsEquip?
    var relics: [StarRailChaDetailsOrnament]?
    var ornaments: [StarRailChaDetailsOrnament]?
    var ranks: [StarRailChaDetailsRank]?
    var properties: [StarRailChaDetailsPropertyElement]?
    var skills: [StarRailChaDetailsSkill]?
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

// MARK: - StarRailChaDetailsEquip
struct StarRailChaDetailsEquip: Mappable {
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

// MARK: - StarRailChaDetailsOrnament
struct StarRailChaDetailsOrnament: Mappable {
    var id: Int = 0
    var level: Int = 1
    var pos: Int = 0
    var name: String = ""
    var desc: String = ""
    var icon: String = ""
    var rarity: RarityType = .one
    var mainProperty: StarRailChaDetailsMainPropertyClass?
    var properties: [StarRailChaDetailsMainPropertyClass]?
    
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

// MARK: - StarRailChaDetailsMainPropertyClass
struct StarRailChaDetailsMainPropertyClass: Mappable {
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

// MARK: - StarRailChaDetailsPropertyElement
struct StarRailChaDetailsPropertyElement: Mappable {
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

// MARK: - StarRailChaDetailsRank
struct StarRailChaDetailsRank: Mappable {
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

// MARK: - StarRailChaDetailsSkill
struct StarRailChaDetailsSkill: Mappable {
    var pointID: String?
    var pointType: Int?
    var itemURL: String?
    var level: Int = 1
    var isActivated: Bool?
    var isRankWork: Bool?
    var prePoint: String?
    var anchor: String?
    var remake: String?
    var skillStages: [StarRailChaDetailsSkillStage]?
    
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

// MARK: - StarRailChaDetailsSkillStage
struct StarRailChaDetailsSkillStage: Mappable {
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

// MARK: - StarRailChaDetailsEquipWiki
struct StarRailChaDetailsEquipWiki {
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

// MARK: - StarRailChaDetailsPropertyInfo
struct StarRailChaDetailsPropertyInfo {
    var the1: StarRailChaDetailsThe1?
    var the2: StarRailChaDetailsThe1?
    var the3: StarRailChaDetailsThe1?
    var the4: StarRailChaDetailsThe1?
    var the5: StarRailChaDetailsThe1?
    var the6: StarRailChaDetailsThe1?
    var the7: StarRailChaDetailsThe1?
    var the8: StarRailChaDetailsThe1?
    var the9: StarRailChaDetailsThe1?
    var the10: StarRailChaDetailsThe1?
    var the11: StarRailChaDetailsThe1?
    var the12: StarRailChaDetailsThe1?
    var the13: StarRailChaDetailsThe1?
    var the14: StarRailChaDetailsThe1?
    var the15: StarRailChaDetailsThe1?
    var the16: StarRailChaDetailsThe1?
    var the17: StarRailChaDetailsThe1?
    var the18: StarRailChaDetailsThe1?
    var the19: StarRailChaDetailsThe1?
    var the20: StarRailChaDetailsThe1?
    var the21: StarRailChaDetailsThe1?
    var the22: StarRailChaDetailsThe1?
    var the23: StarRailChaDetailsThe1?
    var the24: StarRailChaDetailsThe1?
    var the25: StarRailChaDetailsThe1?
    var the26: StarRailChaDetailsThe1?
    var the27: StarRailChaDetailsThe1?
    var the28: StarRailChaDetailsThe1?
    var the29: StarRailChaDetailsThe1?
    var the30: StarRailChaDetailsThe1?
    var the31: StarRailChaDetailsThe1?
    var the32: StarRailChaDetailsThe1?
    var the33: StarRailChaDetailsThe1?
    var the34: StarRailChaDetailsThe1?
    var the35: StarRailChaDetailsThe1?
    var the36: StarRailChaDetailsThe1?
    var the37: StarRailChaDetailsThe1?
    var the38: StarRailChaDetailsThe1?
    var the39: StarRailChaDetailsThe1?
    var the40: StarRailChaDetailsThe1?
    var the41: StarRailChaDetailsThe1?
    var the42: StarRailChaDetailsThe1?
    var the43: StarRailChaDetailsThe1?
    var the51: StarRailChaDetailsThe1?
    var the52: StarRailChaDetailsThe1?
    var the53: StarRailChaDetailsThe1?
    var the54: StarRailChaDetailsThe1?
    var the55: StarRailChaDetailsThe1?
    var the56: StarRailChaDetailsThe1?
    var the57: StarRailChaDetailsThe1?
    var the58: StarRailChaDetailsThe1?
    var the59: StarRailChaDetailsThe1?
    var the60: StarRailChaDetailsThe1?
}

// MARK: - StarRailChaDetailsThe1
struct StarRailChaDetailsThe1: Mappable {
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

// MARK: - StarRailChaDetailsRecommendProperty
struct StarRailChaDetailsRecommendProperty {
    var the1001: StarRailChaDetailsThe1001?
    var the1002: StarRailChaDetailsThe1001?
    var the1003: StarRailChaDetailsThe1001?
    var the1004: StarRailChaDetailsThe1001?
    var the1005: StarRailChaDetailsThe1001?
    var the1006: StarRailChaDetailsThe1001?
    var the1008: StarRailChaDetailsThe1001?
    var the1009: StarRailChaDetailsThe1001?
    var the1013: StarRailChaDetailsThe1001?
    var the1101: StarRailChaDetailsThe1001?
    var the1102: StarRailChaDetailsThe1001?
    var the1103: StarRailChaDetailsThe1001?
    var the1104: StarRailChaDetailsThe1001?
    var the1105: StarRailChaDetailsThe1001?
    var the1106: StarRailChaDetailsThe1001?
    var the1107: StarRailChaDetailsThe1001?
    var the1108: StarRailChaDetailsThe1001?
    var the1109: StarRailChaDetailsThe1001?
    var the1110: StarRailChaDetailsThe1001?
    var the1111: StarRailChaDetailsThe1001?
    var the1112: StarRailChaDetailsThe1001?
    var the1201: StarRailChaDetailsThe1001?
    var the1202: StarRailChaDetailsThe1001?
    var the1203: StarRailChaDetailsThe1001?
    var the1204: StarRailChaDetailsThe1001?
    var the1205: StarRailChaDetailsThe1001?
    var the1206: StarRailChaDetailsThe1001?
    var the1207: StarRailChaDetailsThe1001?
    var the1208: StarRailChaDetailsThe1001?
    var the1209: StarRailChaDetailsThe1001?
    var the1210: StarRailChaDetailsThe1001?
    var the1211: StarRailChaDetailsThe1001?
    var the1212: StarRailChaDetailsThe1001?
    var the1213: StarRailChaDetailsThe1001?
    var the1214: StarRailChaDetailsThe1001?
    var the1215: StarRailChaDetailsThe1001?
    var the1217: StarRailChaDetailsThe1001?
    var the1302: StarRailChaDetailsThe1001?
    var the1303: StarRailChaDetailsThe1001?
    var the1305: StarRailChaDetailsThe1001?
    var the1306: StarRailChaDetailsThe1001?
    var the1307: StarRailChaDetailsThe1001?
    var the1312: StarRailChaDetailsThe1001?
    var the8001: StarRailChaDetailsThe1001?
    var the8002: StarRailChaDetailsThe1001?
    var the8003: StarRailChaDetailsThe1001?
    var the8004: StarRailChaDetailsThe1001?
}

// MARK: - StarRailChaDetailsThe1001
struct StarRailChaDetailsThe1001: Mappable {
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

// MARK: - StarRailChaDetailsRelicProperty
struct StarRailChaDetailsRelicProperty: Mappable {
    var propertyType: Int?
    var modifyPropertyType: Int?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        propertyType <- map["property_type"]
        modifyPropertyType <- map["modify_property_type"]
    }
}

// MARK: - StarRailChaDetailsRelicWiki
struct StarRailChaDetailsRelicWiki {
}
