//
//  MihoyoCookieTokenModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import Foundation
import ObjectMapper

struct MihoyoCookieTokenModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: MihoyoCookieTokenDataModel?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

struct MihoyoCookieTokenDataModel: Mappable {
    var uid: String?
    var cookieToken: String?

    init?(map: Map) {}

    mutating func mapping(map: Map) {
        uid <- map["uid"]
        cookieToken <- map["cookie_token"]
    }
}
