//
//  GenshinRoleSkillsRequestModel.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation
import ObjectMapper

public struct GenshinRoleSkillsRequestModel: Mappable {
    public var uid: String?
    public var region: String?
    public var avatarID: String?
    
    public init?(map: Map) {}
    public init() {}

    mutating public func mapping(map: ObjectMapper.Map) {
        uid <- map["uid"]
        region <- map["region"]
        avatarID <- map["avatar_id"]
    }
}
