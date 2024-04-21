//
//  StarRailAllRoleModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI
import ObjectMapper

// MARK: - StarRailAllRoleModel
public struct StarRailAllRoleModel: Mappable, Identifiable {
    public var id = UUID()
    public var retcode: Int?
    public var message: String?
    public var data: StarRailAllRoleDataModel?

    public init?(map: Map) { }
    init() { }

    mutating public func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailAllRoleDataModel
public struct StarRailAllRoleDataModel: Mappable, Identifiable {
    public var id = UUID()
    public var list: [StarRailAllRoleListModel]?
    public var isLogin: Bool?

    public init?(map: Map) {
    }

    mutating public func mapping(map: Map) {
        list <- map["list"]
        isLogin <- map["isLogin"]
    }
}

// MARK: - StarRailAllRoleListModel
public struct StarRailAllRoleListModel: Mappable, Identifiable {
    public var id = UUID()
    public var itemID: String?
    public var itemName: String?
    public var iconURL: String?
    public var damageType: StarRailDamageTypes?
    public var rarity: StarRailRarityTypes = .one
    public var avatarBaseType: StarRailDestinyTypes?
    public var maxLevel: Int = 80
    public var curLevel: Int = 1
    public var targetLevel: Int?
    public var verticalIconURL: String?
    public var isForward: Bool?
    
    public var level: String {
        "Lv: \(curLevel) / \(maxLevel)"
    }
    
    init() { }

    init(
        itemID: String?,
        itemName: String?,
        iconURL: String?,
        damageType: StarRailDamageTypes?, 
        rarity: StarRailRarityTypes?, 
        avatarBaseType: StarRailDestinyTypes?,
        maxLevel: Int = 80,
        curLevel: Int = 1,
        targetLevel: Int?,
        verticalIconURL: String?,
        isForward: Bool?
    ) {
        self.itemID = itemID
        self.itemName = itemName
        self.iconURL = iconURL
        self.damageType = damageType
        self.rarity = rarity ?? .one
        self.avatarBaseType = avatarBaseType
        self.maxLevel = maxLevel
        self.curLevel = curLevel
        self.targetLevel = targetLevel
        self.verticalIconURL = verticalIconURL
        self.isForward = isForward
    }

    public init?(map: Map) { }

    mutating public func mapping(map: Map) {
        itemID <- map["item_id"]
        itemName <- map["item_name"]
        iconURL <- map["icon_url"]
        damageType <- map["damage_type"]
        rarity <- map["rarity"]
        avatarBaseType <- map["avatar_base_type"]
        maxLevel <- map["max_level"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
        verticalIconURL <- map["vertical_icon_url"]
        isForward <- map["is_forward"]
    }

    init(
        itemName: String?,
        iconURL: String?,
        targetLevel: Int?
    ) {
        self.itemName = itemName
        self.iconURL = iconURL
        self.targetLevel = targetLevel
    }
}
