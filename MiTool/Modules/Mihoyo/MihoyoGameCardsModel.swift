//
//  MihoyoGameCardsModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import Foundation
import ObjectMapper

// MARK: - MihoyoGameCardsModel
struct MihoyoGameCardsModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: MihoyoGameCardsData?

    init?(map: ObjectMapper.Map) {
    }

    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - MihoyoGameCardsData
struct MihoyoGameCardsData: Mappable {
    var list: [MihoyoGameCardsList]?

    init?(map: ObjectMapper.Map) {
    }

    mutating func mapping(map: ObjectMapper.Map) {
        list <- map["list"]
    }
}

enum MihoyoGameID: Int {
    // 崩坏三
    case honkai3 = 1
    // 原神
    case genshin = 2
    // 星穹铁道
    case starRail = 6
}

// MARK: - MihoyoGameCardsList
struct MihoyoGameCardsList: Mappable, Identifiable {
    var id = UUID()
    var hasRole: Bool?
    var gameID: MihoyoGameID?
    var gameRoleID: String = ""
    var nickname: String = ""
    var region: String = ""
    var level: Int = 1
    var backgroundImage: String = ""
    var isPublic: Bool?
    var data: [MihoyoGameCardsDatum]?
    var regionName: String = ""
    var url: String = ""
    var dataSwitches: [MihoyoGameCardsDataSwitch]?
    var h5DataSwitches: [Any?]?
    var backgroundColor: String = ""
    var backgroundImageV2: String = ""

    var gameName: String {
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

    init?(map: ObjectMapper.Map) {
    }

    mutating func mapping(map: ObjectMapper.Map) {
        hasRole <- map["has_role"]
        gameID <- map["game_id"]
        gameRoleID <- map["game_role_id"]
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
struct MihoyoGameCardsDatum: Mappable, Identifiable {
    var id = UUID()
    var name: String = ""
    var type: Int?
    var value: String = ""

    init?(map: ObjectMapper.Map) {
    }

    mutating func mapping(map: ObjectMapper.Map) {
        name <- map["name"]
        type <- map["type"]
        value <- map["value"]
    }
}

// MARK: - MihoyoGameCardsDataSwitch
struct MihoyoGameCardsDataSwitch: Mappable {
    var switchID: Int?
    var isPublic: Bool?
    var switchName: String = ""

    init?(map: ObjectMapper.Map) {
    }

    mutating func mapping(map: ObjectMapper.Map) {
        switchID <- map["switch_id"]
        isPublic <- map["is_public"]
        switchName <- map["switch_name"]
    }
}
