//
//  MihoyoGameCardsModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import Foundation
import ObjectMapper

// MARK: - MihoyoGameCardsModel
public struct MihoyoGameCardsModel: MihoyoModelProtocol {
    public var retcode: Int = 0
    public var message: String = ""
    public var data: MihoyoGameCardsData?

    public init?(map: ObjectMapper.Map) {
    }

    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - MihoyoGameCardsData
public struct MihoyoGameCardsData: MihoyoDataModelProtocol {
    public var id = UUID()
    public var list: [MihoyoGameCardsList]?

    public init?(map: ObjectMapper.Map) {
    }

    mutating public func mapping(map: ObjectMapper.Map) {
        list <- map["list"]
    }
}

public enum MihoyoGameID: Int {
    // 崩坏三
    case honkai3 = 1
    // 原神
    case genshin = 2
    // 星穹铁道
    case starRail = 6
}

// MARK: - MihoyoGameCardsList
public struct MihoyoGameCardsList: MihoyoDataModelProtocol {
    public var id = UUID()
    public var hasRole: Bool?
    public var gameID: MihoyoGameID?
    public var gameRoleID: String = ""
    public var gameUID: String = ""
    public var nickname: String = ""
    public var region: String = ""
    public var level: Int = 1
    public var backgroundImage: String = ""
    public var isPublic: Bool?
    public var data: [MihoyoGameCardsDatum]?
    public var regionName: String = ""
    public var url: String = ""
    public var dataSwitches: [MihoyoGameCardsDataSwitch]?
    public var h5DataSwitches: [Any?]?
    public var backgroundColor: String = ""
    public var backgroundImageV2: String = ""

    public var gameName: String {
        switch gameID {
        case .honkai3:
            return CopyGameName.honkai3
        case .genshin:
            return CopyGameName.genshin
        case .starRail:
            return CopyGameName.starRail
        case nil:
            return CopyGameName.unknown
        }
    }

    public init() { }
    
    public init?(map: ObjectMapper.Map) {
    }

    mutating public func mapping(map: ObjectMapper.Map) {
        hasRole <- map["has_role"]
        gameID <- map["game_id"]
        gameRoleID <- map["game_role_id"]
        gameUID <- map["game_uid"]
        nickname <- map["nickname"]
        region <- map["region"]
        level <- map["level"]
        backgroundImage <- map["background_image"]
        isPublic <- map["is_public"]
        data <- map["data"]
        regionName <- map["region_name"]
        url <- map["url"]
        dataSwitches <- map["data_switches"]
        h5DataSwitches <- map["h5_data_switches"]
        backgroundColor <- map["background_color"]
        backgroundImageV2 <- map["background_image_v2"]
    }
}

// MARK: - MihoyoGameCardsDatum
public struct MihoyoGameCardsDatum: MihoyoDataModelProtocol {
    public var id = UUID()
    public var name: String = ""
    public var type: Int?
    public var value: String = ""

    public init?(map: ObjectMapper.Map) {
    }

    mutating public func mapping(map: ObjectMapper.Map) {
        name <- map["name"]
        type <- map["type"]
        value <- map["value"]
    }
}

// MARK: - MihoyoGameCardsDataSwitch
public struct MihoyoGameCardsDataSwitch: MihoyoDataModelProtocol {
    public var id = UUID()
    public var switchID: Int?
    public var isPublic: Bool?
    public var switchName: String = ""

    public init?(map: ObjectMapper.Map) {
    }

    mutating public func mapping(map: ObjectMapper.Map) {
        switchID <- map["switch_id"]
        isPublic <- map["is_public"]
        switchName <- map["switch_name"]
    }
}
