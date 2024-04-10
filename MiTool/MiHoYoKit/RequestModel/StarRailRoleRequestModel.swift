//
//  StarRailRoleRequestModel.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import ObjectMapper

struct StarRailRoleRequestModel: Mappable {
    var uid: String?
    var region: String?
    var game: String = "hkrpg"
    var lang: String = LanguageManager.getLang()
    var tabFrom: String = "TabOwned"
    var page: Int = 1
    var size: Int = 100

    init?(map: Map) { }
    
    init(uid: String, region: String, page: Int) {
        self.uid = uid
        self.region = region
        self.page = page
    }

    mutating func mapping(map: Map) {
        game <- map["game"]
        uid <- map["uid"]
        region <- map["region"]
        lang <- map["lang"]
        tabFrom <- map["tab_from"]
        page <- map["page"]
        size <- map["size"]
    }
}
