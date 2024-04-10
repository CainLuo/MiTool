//
//  StarRailSkillComputeModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/26.
//

import Foundation
import ObjectMapper

// MARK: - StarRailSkillComputeModel
public struct StarRailSkillComputeModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: StarRailSkillComputeData?

    public init?(map: ObjectMapper.Map) { }

    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailSkillComputeData
public struct StarRailSkillComputeData: Mappable {
    // 等级培养耗材
    public var avatarConsume: [StarRailSkillComputeAvatarConsume]?
    // 行迹培养耗材
    public var skillConsume: [StarRailSkillComputeAvatarConsume]?
    // 光锥培养耗材
    public var equipmentConsume: [StarRailSkillComputeAvatarConsume]?
    // 用户需要自备的材料
    public var userOwnsMaterials: [String: Int]?
    // 除去背包内还需要获取的材料
    public var needGetMaterials: [StarRailSkillComputeAvatarConsume]?
    // 背包里可以支出的材料
    public var canPayMaterials: [StarRailSkillComputeAvatarConsume]?
    // 背包里可以合并的材料
    public var canMergeMaterials: [StarRailSkillComputeAvatarConsume]?
    // ID
    public var coinID: String?
    // 角色 ID
    public var roleID: String?

    public var userOwnsMaterialsString: String? {
        userOwnsMaterials?.toJSONString
    }

    public init?(map: ObjectMapper.Map) { }
    public init() { }

    init(
        avatarConsume: String?,
        skillConsume: String?,
        equipmentConsume: String?,
        userOwnsMaterials: String?,
        needGetMaterials: String?,
        canPayMaterials: String?,
        canMergeMaterials: String?,
        coinID: String?,
        roleID: String?
    ) {
        self.avatarConsume = [StarRailSkillComputeAvatarConsume](JSONString: avatarConsume ?? "") ?? []
        self.skillConsume = [StarRailSkillComputeAvatarConsume](JSONString: skillConsume ?? "") ?? []
        self.equipmentConsume = [StarRailSkillComputeAvatarConsume](JSONString: equipmentConsume ?? "") ?? []
        self.userOwnsMaterials = userOwnsMaterials?.toJSON
        self.needGetMaterials = [StarRailSkillComputeAvatarConsume](JSONString: needGetMaterials ?? "") ?? []
        self.canPayMaterials = [StarRailSkillComputeAvatarConsume](JSONString: canPayMaterials ?? "") ?? []
        self.canMergeMaterials = [StarRailSkillComputeAvatarConsume](JSONString: canMergeMaterials ?? "") ?? []
        self.coinID = coinID
        self.roleID = roleID
    }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatarConsume <- map["avatar_consume"]
        skillConsume <- map["skill_consume"]
        equipmentConsume <- map["equipment_consume"]
        userOwnsMaterials <- map["user_owns_materials"]
        needGetMaterials <- map["need_get_materials"]
        canPayMaterials <- map["can_pay_materials"]
        canMergeMaterials <- map["can_merge_materials"]
        coinID <- map["coin_id"]
    }
}

// MARK: - StarRailSkillComputeAvatarConsume
public struct StarRailSkillComputeAvatarConsume: Mappable, Identifiable {
    public var id = UUID()
    public var itemID: String?
    public var itemName: String?
    public var itemURL: String?
    public var num: Int?
    public var wikiURL: String?
    public var rarity: RarityType?

    public init?(map: ObjectMapper.Map) { }

    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        itemID <- map["item_id"]
        itemName <- map["item_name"]
        itemURL <- map["item_url"]
        num <- map["num"]
        wikiURL <- map["wiki_url"]
        rarity <- map["rarity"]
    }
}

// MARK: - Local Model
public struct StarRailLocalCompute: Identifiable {
    public var id = UUID()
    public var title: String = ""
    public var consume: [StarRailSkillComputeAvatarConsume] = []
}
