//
//  GenshinRoleSkillModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import Foundation
import ObjectMapper

// MARK: - GenshinCharacterModel
public struct GenshinRoleSkillModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: GenshinRoleSkillDataModel?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

public struct GenshinRoleSkillDataModel: Mappable {
    public var skillList: [Skill] = []

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        skillList <- map["data.skill_list"]
    }
}

public struct Skill: Mappable {
    public var id: Int = 0
    public var groupId: Int = 0
    public var name: String = ""
    public var icon: String = ""
    public var maxLevel: Int = 10
    public var currentLevel: Int = 1

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        id <- map["id"]
        groupId <- map["group_id"]
        name <- map["name"]
        icon <- map["icon"]
        maxLevel <- map["max_level"]
        currentLevel <- map["level_current"]
    }
}
