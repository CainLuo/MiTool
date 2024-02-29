//
//  GenshinImpactCharacterModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import ObjectMapper

// MARK: - GenshinImpactCharacterModel
struct GenshinImpactCharacterModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: GenshinImpactCharacterData?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - GenshinImpactCharacterData
struct GenshinImpactCharacterData: Mappable {
    var avatars: [GenshinImpactCharacterAvatar]?
    var role: GenshinImpactCharacterRole?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        avatars <- map["avatars"]
        role <- map["role"]
    }
}

// MARK: - GenshinImpactCharacterAvatar
struct GenshinImpactCharacterAvatar: Mappable {
    var id: Int?
    var image: String?
    var icon: String?
    var name: String?
    var element: String?
    var fetter: Int?
    var level: Int?
    var rarity: Int?
    var weapon: GenshinImpactCharacterWeapon?
    var reliquaries: [GenshinImpactCharacterReliquary]?
    var constellations: [GenshinImpactCharacterConstellation]?
    var activedConstellationNum: Int?
    var costumes: [Any?]?
    var external: NSNull?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        image <- map["image"]
        icon <- map["icon"]
        name <- map["name"]
        element <- map["element"]
        fetter <- map["fetter"]
        level <- map["level"]
        rarity <- map["rarity"]
        weapon <- map["weapon"]
        reliquaries <- map["reliquaries"]
        constellations <- map["constellations"]
        activedConstellationNum <- map["actived_constellation_num"]
        costumes <- map["costumes"]
        external <- map["external"]
    }
}

// MARK: - GenshinImpactCharacterConstellation
struct GenshinImpactCharacterConstellation: Mappable {
    var id: Int?
    var name: String?
    var icon: String?
    var effect: String?
    var isActived: Bool?
    var pos: Int?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        effect <- map["effect"]
        isActived <- map["is_actived"]
        pos <- map["pos"]
    }
}

// MARK: - GenshinImpactCharacterReliquary
struct GenshinImpactCharacterReliquary: Mappable {
    var id: Int?
    var name: String?
    var icon: String?
    var pos: Int?
    var rarity: Int?
    var level: Int?
    var reliquarySet: GenshinImpactCharacterSet?
    var posName: String?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        pos <- map["pos"]
        rarity <- map["rarity"]
        level <- map["level"]
        reliquarySet <- map["set"]
        posName <- map["pos_name"]
    }
}

// MARK: - GenshinImpactCharacterSet
struct GenshinImpactCharacterSet: Mappable {
    var id: Int?
    var name: String?
    var affixes: [GenshinImpactCharacterAffix]?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        affixes <- map["affixes"]
    }
}

// MARK: - GenshinImpactCharacterAffix
struct GenshinImpactCharacterAffix: Mappable {
    var activationNumber: Int?
    var effect: String?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        activationNumber <- map["activation_number"]
        effect <- map["effect"]
    }
}

// MARK: - GenshinImpactCharacterWeapon
struct GenshinImpactCharacterWeapon: Mappable {
    var id: Int?
    var name: String?
    var icon: String?
    var type: Int?
    var rarity: Int?
    var level: Int?
    var promoteLevel: Int?
    var typeName: String?
    var desc: String?
    var affixLevel: Int?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        type <- map["type"]
        rarity <- map["rarity"]
        level <- map["level"]
        promoteLevel <- map["promote_level"]
        typeName <- map["type_name"]
        desc <- map["desc"]
        affixLevel <- map["affix_level"]
    }
}

// MARK: - GenshinImpactCharacterRole
struct GenshinImpactCharacterRole: Mappable {
    var avatarURL: String?
    var nickname: String?
    var region: String?
    var level: Int?

    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        avatarURL <- map["AvatarUrl"]
        nickname <- map["nickname"]
        region <- map["region"]
        level <- map["level"]
    }
}
