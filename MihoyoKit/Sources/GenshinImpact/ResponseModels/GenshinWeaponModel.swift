//
//  GenshinWeaponModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/5.
//

import Foundation
import ObjectMapper

public struct GenshinWeaponModel: MihoyoModelProtocol {
    public var retcode: Int = 0
    public var message: String = ""
    public var data: GenshinWeaponDataModel?

    public init?(map: Map) {}
    public init() { }

    mutating public func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

public struct GenshinWeaponDataModel: MihoyoDataModelProtocol {
    public var id = UUID()
    public var list: [GenshinWeaponItemModel] = []

    public init?(map: Map) {}
    public init() { }

    mutating public func mapping(map: Map) {
        list <- map["list"]
    }
}

public struct GenshinWeaponItemModel: MihoyoDataModelProtocol {
    public var id = UUID()
    public var weaponID: Int?
    public var name: String?
    public var icon: String?
    public var weaponCatId: Int?
    public var weaponLevel: GenshinRarityType = .one
    public var maxLevel: Int?
    
    public var computeInfo: [GenshinWeaponComputeItemModel] = []

    public init?(map: Map) {}
    public init() { }
    public init(
        id: Int?,
        name: String?,
        icon: String?,
        weaponCatId: Int?,
        weaponLevel: Int?,
        maxLevel: Int?,
        computeInfo: String?
    ) {
        self.weaponID = id
        self.name = name
        self.icon = icon
        self.weaponCatId = weaponCatId
        self.weaponLevel = GenshinRarityType(rawValue: weaponLevel ?? 0) ?? .one
        self.maxLevel = maxLevel
        self.computeInfo = [GenshinWeaponComputeItemModel](JSONString: computeInfo ?? "") ?? []
    }
    
    mutating public func mapping(map: Map) {
        weaponID <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        weaponCatId <- map["weapon_cat_id"]
        weaponLevel <- map["weapon_level"]
        maxLevel <- map["max_level"]
    }
}
