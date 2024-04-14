//
//  MihoyoGamesModel.swift
//  MiTool
//
//  Created by Cain on 2024/4/14.
//

import Foundation
import ObjectMapper

public struct MihoyoGamesModel: MihoyoModelProtocol {
    public var retcode: Int = 0
    public var message: String = ""
    public var data: MihoyoGamesDataModel?

    public init?(map: Map) {}

    // An empty constructor
    public init() {}

    // Full constructor
    public init(
        retcode: Int,
        message: String,
        data: MihoyoGamesDataModel?
    ) {
        self.retcode = retcode
        self.message = message
        self.data = data
    }

    public mutating func mapping(map: Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// DataList Model
public struct MihoyoGamesDataModel: MihoyoDataModelProtocol {
    public var id = UUID()
    public var list: [MihoyoGamesItemModel]?

    public init?(map: Map) {}

    // An empty constructor
    public init() {}

    // Full constructor
    public init(list: [MihoyoGamesItemModel]?) {
        self.list = list
    }

    public mutating func mapping(map: Map) {
        list <- map["list"]
    }
}

public struct MihoyoGamesItemModel: Mappable {
    public var gameBiz: String = ""
    public var region: String = ""
    public var gameUID: String = ""
    public var nickname: String = ""
    public var level: Int = 1
    public var isChosen = false
    public var regionName: String = ""
    public var isOfficial = false

    public init?(map: Map) {}

    // An empty constructor
    public init() {}

    // Full constructor
    public init(
        gameBiz: String,
        region: String,
        gameUID: String,
        nickname: String,
        level: Int,
        isChosen: Bool,
        regionName: String,
        isOfficial: Bool
    ) {
        self.gameBiz = gameBiz
        self.region = region
        self.gameUID = gameUID
        self.nickname = nickname
        self.level = level
        self.isChosen = isChosen
        self.regionName = regionName
        self.isOfficial = isOfficial
    }

    public mutating func mapping(map: Map) {
        gameBiz <- map["game_biz"]
        region <- map["region"]
        gameUID <- map["game_uid"]
        nickname <- map["nickname"]
        level <- map["level"]
        isChosen <- map["is_chosen"]
        regionName <- map["region_name"]
        isOfficial <- map["is_official"]
    }
}
