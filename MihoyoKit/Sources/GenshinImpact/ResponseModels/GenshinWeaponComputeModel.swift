//
//  GenshinWeaponComputeModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/5.
//

import Foundation
import ObjectMapper

public struct GenshinWeaponComputeModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: GenshinWeaponComputeDataModel?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

public struct GenshinWeaponComputeDataModel: Mappable {
    public var avatarConsume: [GenshinWeaponComputeItemModel]?
    public var avatarSkillConsume: [GenshinWeaponComputeItemModel]?
    public var weaponConsume: [GenshinWeaponComputeItemModel]?
    public var reliquaryConsume: [GenshinWeaponComputeItemModel]?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        avatarConsume <- map["avatar_consume"]
        avatarSkillConsume <- map["avatar_skill_consume"]
        weaponConsume <- map["weapon_consume"]
        reliquaryConsume <- map["reliquary_consume"]
    }
}

public struct GenshinWeaponComputeItemModel: Mappable, Identifiable {
    public var id = UUID()
    public var computID: Int?
    public var name: String = ""
    public var icon: String = ""
    public var num: Int = 0
    public var wikiURL: String = ""
    public var level: Int = 0
    public var iconURL: String = ""

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        computID <- map["computID"]
        name <- map["name"]
        icon <- map["icon"]
        num <- map["num"]
        wikiURL <- map["wiki_url"]
        level <- map["level"]
        iconURL <- map["icon_url"]
    }
}
