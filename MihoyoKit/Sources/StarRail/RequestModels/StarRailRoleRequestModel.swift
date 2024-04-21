//
//  StarRailRoleRequestModel.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import ObjectMapper

public struct StarRailRoleRequestModel: StarRailRequestModelProtocol {
    var uid: String?
    var region: String?
    var game: StarRailGameName = .hkrpg
    var lang: String = LanguageManager.getLowLang()
    var tabFrom: StarRailTabFromTypes = .tabOwned
    var page: Int = 1
    var size: Int = 100

    public init?(map: Map) { }
    
    public init(uid: String, region: String, page: Int) {
        self.uid = uid
        self.region = region
        self.page = page
    }

    mutating public func mapping(map: Map) {
        game <- map["game"]
        uid <- map["uid"]
        region <- map["region"]
        lang <- map["lang"]
        tabFrom <- map["tab_from"]
        page <- map["page"]
        size <- map["size"]
    }
}
