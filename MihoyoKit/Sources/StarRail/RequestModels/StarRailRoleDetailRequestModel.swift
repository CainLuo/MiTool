//
//  StarRailRoleDetailRequestModel.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import ObjectMapper

public struct StarRailRoleDetailRequestModel: StarRailRequestModelProtocol {
    var uid: String?
    var region: String?
    var itemID: String?
    var changeTargetLevel: Int?
    var game: StarRailGameName = .hkrpg
    var tabFrom: StarRailTabFromTypes = .tabOwned
    var lang: String = LanguageManager.getLowLang()

    public init?(map: Map) {}
    public init(
        uid: String?,
        region: String?,
        itemID: String?,
        changeTargetLevel: Int?
    ) {
        self.uid = uid
        self.itemID = itemID
        self.region = region
        self.changeTargetLevel = changeTargetLevel
    }
    
    mutating public func mapping(map: Map) {
        game <- map["game"]
        lang <- map["lang"]
        itemID <- map["item_id"]
        tabFrom <- map["tab_from"]
        changeTargetLevel <- map["change_target_level"]
        uid <- map["uid"]
        region <- map["region"]
    }
}
