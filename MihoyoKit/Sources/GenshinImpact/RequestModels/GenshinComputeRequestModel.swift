//
//  File.swift
//  
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation
import ObjectMapper

public struct GensinComputeRequestModel: Mappable {
    public var id: Int?
    public var levelCurrent: Int?
    public var levelTarget: Int?
    public var elementAttrId: Int?
    public var skillList: [GensinComputeRequestTargetModel]?
    public var weapon: GensinComputeRequestTargetModel?
    public var reliquaryList: [GensinComputeRequestTargetModel]?

    public init?(map: Map){}
    public init(
        id: Int? = nil,
        levelCurrent: Int? = nil,
        levelTarget: Int? = nil,
        elementAttrId: Int? = nil,
        skillList: [GensinComputeRequestTargetModel]? = nil,
        weapon: GensinComputeRequestTargetModel?,
        reliquaryList: [GensinComputeRequestTargetModel]? = []
    ) {
        self.id = id
        self.levelCurrent = levelCurrent
        self.levelTarget = levelTarget
        self.elementAttrId = elementAttrId
        self.skillList = skillList
        self.weapon = weapon
        self.reliquaryList = reliquaryList
    }

    public mutating func mapping(map: Map) {
        id <- map["avatar_id"]
        levelCurrent <- map["avatar_level_current"]
        levelTarget <- map["avatar_level_target"]
        elementAttrId <- map["element_attr_id"]
        skillList <- map["skill_list"]
        weapon <- map["weapon"]
        reliquaryList <- map["reliquary_list"]
    }
}

public struct GensinComputeRequestTargetModel: Mappable {
    public var id: Int?
    public var levelCurrent: Int?
    public var levelTarget: Int?

    public init?(map: Map){}
    public init(
        id: Int?,
        levelCurrent: Int?,
        levelTarget: Int?
    ) {
        self.id = id
        self.levelCurrent = levelCurrent
        self.levelTarget = levelTarget
    }

    public mutating func mapping(map: Map) {
        id <- map["id"]
        levelCurrent <- map["level_current"]
        levelTarget <- map["level_target"]
    }
}
