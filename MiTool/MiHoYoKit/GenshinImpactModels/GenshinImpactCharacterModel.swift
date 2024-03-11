//
//  GenshinImpactCharacterModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import ObjectMapper

// MARK: - GenshinImpactCharacterModel
public struct GenshinImpactCharacterModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: GenshinImpactCharacterData?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - GenshinImpactCharacterData
public struct GenshinImpactCharacterData: Mappable {
    public var avatars: [GenshinImpactCharacterAvatar]?
    public var role: GenshinImpactCharacterRole?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatars <- map["avatars"]
        role <- map["role"]
    }
}

// MARK: - GenshinImpactCharacterAvatar
public struct GenshinImpactCharacterAvatar: Mappable {
    public var id: Int?
    public var image: String?
    public var icon: String?
    public var name: String?
    public var element: String?
    public var fetter: Int?
    public var level: Int?
    public var rarity: Int?
    public var weapon: GenshinImpactCharacterWeapon?
    public var reliquaries: [GenshinImpactCharacterReliquary]?
    public var constellations: [GenshinImpactCharacterConstellation]?
    public var activedConstellationNum: Int?
    public var costumes: [Any?]?
    public var external: NSNull?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
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
public struct GenshinImpactCharacterConstellation: Mappable {
    public var id: Int?
    public var name: String?
    public var icon: String?
    public var effect: String?
    public var isActived: Bool?
    public var pos: Int?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        effect <- map["effect"]
        isActived <- map["is_actived"]
        pos <- map["pos"]
    }
}

// MARK: - GenshinImpactCharacterReliquary
public struct GenshinImpactCharacterReliquary: Mappable {
    public var id: Int?
    public var name: String?
    public var icon: String?
    public var pos: Int?
    public var rarity: Int?
    public var level: Int?
    public var reliquarySet: GenshinImpactCharacterSet?
    public var posName: String?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
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
public struct GenshinImpactCharacterSet: Mappable {
    public var id: Int?
    public var name: String?
    public var affixes: [GenshinImpactCharacterAffix]?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        affixes <- map["affixes"]
    }
}

// MARK: - GenshinImpactCharacterAffix
public struct GenshinImpactCharacterAffix: Mappable {
    public var activationNumber: Int?
    public var effect: String?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        activationNumber <- map["activation_number"]
        effect <- map["effect"]
    }
}

// MARK: - GenshinImpactCharacterWeapon
public struct GenshinImpactCharacterWeapon: Mappable {
    public var id: Int?
    public var name: String?
    public var icon: String?
    public var type: Int?
    public var rarity: Int?
    public var level: Int?
    public var promoteLevel: Int?
    public var typeName: String?
    public var desc: String?
    public var affixLevel: Int?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
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
public struct GenshinImpactCharacterRole: Mappable {
    public var avatarURL: String?
    public var nickname: String?
    public var region: String?
    public var level: Int?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatarURL <- map["AvatarUrl"]
        nickname <- map["nickname"]
        region <- map["region"]
        level <- map["level"]
    }
}
