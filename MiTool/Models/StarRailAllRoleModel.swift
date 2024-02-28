//
//  StarRailAllRoleModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI
import ObjectMapper

// MARK: - StarRailAllRoleModel
struct StarRailAllRoleModel: Mappable, Identifiable {
    var id = UUID()
    var retcode: Int?
    var message: String?
    var data: StarRailAllRoleDataModel?
    
    init?(map: Map) { }
    init() { }
    
    mutating func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailAllRoleDataModel
struct StarRailAllRoleDataModel: Mappable, Identifiable {
    var id = UUID()
    var list: [StarRailAllRoleListModel]?
    var isLogin: Bool?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        list <- map["list"]
        isLogin <- map["isLogin"]
    }
}

// MARK: - StarRailAllRoleListModel
struct StarRailAllRoleListModel: Mappable, Identifiable {
    var id = UUID()
    var itemID: String?
    var itemName: String?
    var iconURL: String?
    var damageType: Damage?
    var rarity: RarityType?
    var avatarBaseType: Destiny?
    var maxLevel: Int?
    var curLevel: Int?
    var targetLevel: Int?
    var verticalIconURL: String?
    var isForward: Bool?
    
    init(itemID: String?, itemName: String?, iconURL: String?,
         damageType: Damage?, rarity: RarityType?, avatarBaseType: Destiny?,
         maxLevel: Int?, curLevel: Int?, targetLevel: Int?, verticalIconURL: String?,
         isForward: Bool?) {
        self.itemID = itemID
        self.itemName = itemName
        self.iconURL = iconURL
        self.damageType = damageType
        self.rarity = rarity
        self.avatarBaseType = avatarBaseType
        self.maxLevel = maxLevel
        self.curLevel = curLevel
        self.targetLevel = targetLevel
        self.verticalIconURL = verticalIconURL
        self.isForward = isForward
    }
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
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
    
    init(itemName: String?,
         iconURL: String?,
         targetLevel: Int?) {
        self.itemName = itemName
        self.iconURL = iconURL
        self.targetLevel = targetLevel
    }
}
