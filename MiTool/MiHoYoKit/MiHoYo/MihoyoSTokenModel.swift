//
//  MihoyoSTokenModel.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import ObjectMapper

public struct MihoyoSTokenModel: Mappable {
    public var retcode: Int = 0
    public var message: String = ""
    public var data: MihoyoSTokenDataModel?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

public struct MihoyoSTokenDataModel: Mappable {
    public var token: MihoyoSTokenTokenModel?

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        token <- map["token"]
    }
}

public struct MihoyoSTokenTokenModel: Mappable {
    public var tokenType: Int = 0
    public var token: String = ""

    public init?(map: Map) {}

    public mutating func mapping(map: Map) {
        tokenType <- map["token_type"]
        token <- map["token"]
    }
}
