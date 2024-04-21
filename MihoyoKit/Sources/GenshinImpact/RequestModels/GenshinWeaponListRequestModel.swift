//
//  GenshinWeaponListRequestModel.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation
import ObjectMapper

public struct GenshinWeaponListRequestModel: Mappable {
    public var weaponCatIds: [Int] = []
    public var weaponLevels: [Int] = []
    public var page: Int = 1
    public var size: Int = 20
    
    public init?(map: ObjectMapper.Map) {
    }
    
    public init(page: Int = 1) {
        self.page = page
    }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        weaponCatIds <- map["weapon_cat_ids"]
        weaponLevels <- map["weapon_levels"]
        page <- map["page"]
        size <- map["size"]
    }
}
