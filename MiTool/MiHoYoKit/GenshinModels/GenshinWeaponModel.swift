//
//  GenshinWeaponModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/5.
//

import Foundation
import ObjectMapper

public class GenshinWeaponModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: GenshinWeaponDataModel?

    public required init?(map: Map) {}

    public func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

public class GenshinWeaponDataModel: Mappable {
    public var list: [GenshinWeaponItemModel] = []

    public required init?(map: Map) {}

    public func mapping(map: Map) {
        list <- map["list"]
    }
}

public class GenshinWeaponItemModel: Mappable, Identifiable {
    public var id = UUID()
    public var weaponID: Int?
    public var name: String?
    public var icon: String?
    public var weaponCatId: Int?
    public var weaponLevel: GenshinRarityType = .one
    public var maxLevel: Int?
    
    public var computeInfo: [GenshinWeaponComputeItemModel] = []

    public required init?(map: Map) {}
    init() { }
    init(
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
    
    public func mapping(map: Map) {
        weaponID <- map["id"]
        name <- map["name"]
        icon <- map["icon"]
        weaponCatId <- map["weapon_cat_id"]
        weaponLevel <- map["weapon_level"]
        maxLevel <- map["max_level"]
    }
}
