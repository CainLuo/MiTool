//
//  GenshinCharacterModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import ObjectMapper

// MARK: - GenshinCharacterModel
public struct GenshinCharacterModel: MihoyoModelProtocol {
    public var retcode: Int = 0
    public var message: String = ""
    public var data: GenshinCharacterData?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - GenshinCharacterData
public struct GenshinCharacterData: MihoyoDataModelProtocol {
    public var id = UUID()
    public var avatars: [GenshinCharacterAvatar]?
    public var role: GenshinCharacterRole?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatars <- map["avatars"]
        role <- map["role"]
    }
}

// MARK: - GenshinCharacterAvatar
public struct GenshinCharacterAvatar: MihoyoDataModelProtocol {
    public var id = UUID()
    public var avatarID: Int?
    public var image: String?
    public var icon: String?
    public var name: String?
    public var element: String?
    public var fetter: Int?
    public var level: Int = 1
    public var rarity: GenshinRarityType = .one
    public var weapon: GenshinCharacterWeapon?
    public var reliquaries: [GenshinCharacterReliquary]?
    public var constellations: [GenshinCharacterConstellation]?
    public var activedConstellationNum: Int?
    public var costumes: [GenshinCharacterCostumes]?
    public var external: NSNull?
    public var skillList: [GenshinRoleSkillItemModel]?

    public init?(map: ObjectMapper.Map) { }
    init() { }
    init(
        avatarID: Int?,
        image: String?,
        icon: String?,
        name: String?,
        element: String?,
        fetter: Int?,
        level: Int?,
        rarity: Int?,
        weapon: String?,
        reliquaries: String?,
        constellations: String?,
        activedConstellationNum: Int?,
        costumes: String?,
        skillList: String?
    ) {
        self.avatarID = avatarID
        self.image = image
        self.icon = icon
        self.name = name
        self.element = element
        self.fetter = fetter
        self.level = level ?? 1
        self.rarity = GenshinRarityType(rawValue: rarity ?? 0) ?? .one
        self.weapon = GenshinCharacterWeapon(JSONString: weapon ?? "")
        self.reliquaries = [GenshinCharacterReliquary](JSONString: reliquaries ?? "")
        self.constellations = [GenshinCharacterConstellation](JSONString: constellations ?? "")
        self.activedConstellationNum = activedConstellationNum
        self.costumes = [GenshinCharacterCostumes](JSONString: costumes ?? "")
        self.skillList = [GenshinRoleSkillItemModel](JSONString: skillList ?? "")
    }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatarID <- map["id"]
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

// MARK: - GenshinCharacterConstellation
public struct GenshinCharacterConstellation: MihoyoDataModelProtocol {
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

// MARK: - GenshinCharacterReliquary
public struct GenshinCharacterReliquary: MihoyoDataModelProtocol {
    public var id = UUID()
    public var reliquaryID: Int?
    public var name: String?
    public var icon: String?
    public var pos: Int?
    public var rarity: Int?
    public var level: Int?
    public var reliquarySet: GenshinCharacterSet?
    public var posName: String?
    
    public var iconURL: String {
        icon ?? ""
    }
    
    public var levelString: String {
        "Lv: \(level ?? 1)"
    }

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        reliquaryID <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        pos <- map["pos"]
        rarity <- map["rarity"]
        level <- map["level"]
        reliquarySet <- map["set"]
        posName <- map["pos_name"]
    }
}

// MARK: - GenshinCharacterSet
public struct GenshinCharacterSet: MihoyoDataModelProtocol {
    public var id: Int?
    public var name: String?
    public var affixes: [GenshinCharacterAffix]?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        affixes <- map["affixes"]
    }
}

// MARK: - GenshinCharacterAffix
public struct GenshinCharacterAffix: MihoyoDataModelProtocol {
    public var id = UUID()
    public var activationNumber: Int?
    public var effect: String?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        activationNumber <- map["activation_number"]
        effect <- map["effect"]
    }
}

// MARK: - GenshinCharacterWeapon
public struct GenshinCharacterWeapon: MihoyoDataModelProtocol {
    public var id: Int?
    public var name: String?
    public var icon: String?
    public var type: Int?
    public var rarity: Int?
    public var level: Int = 1
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

public struct GenshinCharacterCostumes: MihoyoDataModelProtocol {
    public var id: Int = 0
    public var name: String = ""
    public var icon: String = ""

    public init?(map: ObjectMapper.Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
    }
}

// MARK: - GenshinCharacterRole
public struct GenshinCharacterRole: MihoyoDataModelProtocol {
    public var id = UUID()
    public var avatarURL: String = ""
    public var nickname: String = ""
    public var region: String?
    public var level: Int = 1

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatarURL <- map["AvatarUrl"]
        nickname <- map["nickname"]
        region <- map["region"]
        level <- map["level"]
    }
}
