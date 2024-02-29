//
//  StarRailSkillComputeModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/26.
//

import Foundation
import ObjectMapper

// MARK: - StarRailSkillComputeModel
struct StarRailSkillComputeModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: StarRailSkillComputeData?

    init?(map: ObjectMapper.Map) { }

    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailSkillComputeData
struct StarRailSkillComputeData: Mappable {
    // 等级培养耗材
    var avatarConsume: [StarRailSkillComputeAvatarConsume]?
    // 行迹培养耗材
    var skillConsume: [StarRailSkillComputeAvatarConsume]?
    // 光锥培养耗材
    var equipmentConsume: [StarRailSkillComputeAvatarConsume]?
    // 用户需要自备的材料
    var userOwnsMaterials: [String: Int]?
    // 除去背包内还需要获取的材料
    var needGetMaterials: [StarRailSkillComputeAvatarConsume]?
    // 背包里可以支出的材料
    var canPayMaterials: [StarRailSkillComputeAvatarConsume]?
    // 背包里可以合并的材料
    var canMergeMaterials: [StarRailSkillComputeAvatarConsume]?
    // ID
    var coinID: String?

    var userOwnsMaterialsString: String? {
        userOwnsMaterials?.toJSONString
    }

    init?(map: ObjectMapper.Map) { }

    init(
        avatarConsume: String?,
        skillConsume: String?,
        equipmentConsume: String?,
        userOwnsMaterials: String?,
        needGetMaterials: String?,
        canPayMaterials: String?,
        canMergeMaterials: String?,
        coinID: String?
    ) {
        self.avatarConsume = [StarRailSkillComputeAvatarConsume](JSONString: avatarConsume ?? "")
        self.skillConsume = [StarRailSkillComputeAvatarConsume](JSONString: skillConsume ?? "")
        self.equipmentConsume = [StarRailSkillComputeAvatarConsume](JSONString: equipmentConsume ?? "")
        self.userOwnsMaterials = userOwnsMaterials?.toJSON
        self.needGetMaterials = [StarRailSkillComputeAvatarConsume](JSONString: needGetMaterials ?? "")
        self.canPayMaterials = [StarRailSkillComputeAvatarConsume](JSONString: canPayMaterials ?? "")
        self.canMergeMaterials = [StarRailSkillComputeAvatarConsume](JSONString: canMergeMaterials ?? "")
        self.coinID = coinID
    }

    mutating func mapping(map: ObjectMapper.Map) {
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
struct StarRailSkillComputeAvatarConsume: Mappable, Identifiable {
    var id = UUID()
    var itemID: String?
    var itemName: String?
    var itemURL: String?
    var num: Int?
    var wikiURL: String?
    var rarity: RarityType?

    init?(map: ObjectMapper.Map) { }

    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        itemID <- map["item_id"]
        itemName <- map["item_name"]
        itemURL <- map["item_url"]
        num <- map["num"]
        wikiURL <- map["wiki_url"]
        rarity <- map["rarity"]
    }
}

// MARK: - Local Model
struct StarRailLocalCompute: Identifiable {
    var id = UUID()
    var title: String = ""
    var consume: [StarRailSkillComputeAvatarConsume] = []
}
