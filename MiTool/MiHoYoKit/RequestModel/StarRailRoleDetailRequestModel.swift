//
//  StarRailRoleDetailRequestModel.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import ObjectMapper

class StarRailRoleDetailRequestModel: Mappable {
    var uid: String?
    var region: String?
    var itemID: String?
    var changeTargetLevel: Int?
    var game: String = "hkrpg"
    var tabFrom: String = "TabOwned"
    var lang: String = LanguageManager.getLang()

    required init?(map: Map) {}
    
    init(
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
    
    func mapping(map: Map) {
        game <- map["game"]
        lang <- map["lang"]
        itemID <- map["item_id"]
        tabFrom <- map["tab_from"]
        changeTargetLevel <- map["change_target_level"]
        uid <- map["uid"]
        region <- map["region"]
    }
}
