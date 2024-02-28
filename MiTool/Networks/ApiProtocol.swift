//
//  ApiProtocol.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import Alamofire
import CryptoSwift

struct ApiKeys {
    struct Host {
        static let mihoyo = "https://api-takumi-record.mihoyo.com"
        static let enka = ""
    }
    
    struct Mihoyo {
        // 获取米游社用户的游戏记录
        static let gameRecord = "/game_record/card/api/getGameRecordCard"
    }
    
    struct GenshinImpact {
        // 小组件
        static let widget = "/game_record/app/genshin/aapi/widget/v2"
        // 实时便签
        static let dailyNote = "/game_record/app/genshin/api/dailyNote"
        // 已抽取到的角色
        static let character = "/game_record/app/genshin/api/character"
        // 原神所有的角色
        static let avatarList = "/event/e20200928calculate/v1/avatar/list"
        // 原神所有的 filter, 角色属性, 武器类型
        static let filterList = "/event/e20200928calculate/v1/item/filter"
        // 获取角色的天赋培养材料
        static let avatarSkill = "/event/e20200928calculate/v1/avatarSkill/list"
        // 计算角色的天赋培养材料
        static let compute = "/event/e20200928calculate/v2/compute"
        // 获取深渊记录
        static let spiralAbyss = "/game_record/app/genshin/api/spiralAbyss"
    }
    
    struct StarRail {
        // 小组件
        static let widget = "/game_record/app/hkrpg/aapi/widget"
        // 实时便签
        static let dailyNote = "/game_record/app/hkrpg/api/note"
        // 已抽取到的角色
        static let character = "/game_record/app/hkrpg/api/avatar/basic"
        // 星穹铁道所有的角色
        static let avatarList = "/event/rpgcalc/avatar/list"
        // 星穹铁道角色详情
        static let avatarDetail = "/event/rpgcalc/avatar/detail"
        // 星穹铁道所有光锥
        static let equipmentList = "/event/rpgcalc/equipment/list"
        // 计算角色培养耗材, 等级, 行迹, 光锥
        static let compute = "/event/rpgcalc/compute"
        // 模拟宇宙
        static let rogue = "/game_record/app/hkrpg/api/rogue"
        // 混沌回忆
        static let challenge = "/game_record/app/hkrpg/api/challenge"
    }
}

protocol ApiProtocol {
    // MARK: - Mihoyo User
    func getMihoyoGameRecord() -> MihoyoGameRecordModel
    
    // MARK: - GenshinImpact
    func getGshinImpactWeight() -> GenshinImpactDailyNodeModel
    func getGshinImpactDailyNote() -> GenshinImpactDailyNodeModel
    func getGshinImpactCharacter() -> GenshinImpactCharacterModel
    func getGshinImpactAvatarList() -> Any
    func getGshinImpactFilterList() -> Any
    func getGshinImpactAvatarSkill() -> Any
    func getGshinImpactCompute() -> Any
    func getGshinImpactSpiralAbyss() -> Any

    // MARK: - Honkai: StarRail
    func getStarRailWeight() -> StarRailWeightModel
    func getStarRailDailyNote() -> StarRailWeightModel
    func getStarRailCharacter() -> Any
    func getStarRailAvatarList() -> Any
    func getStarRailAvatarDetail() -> Any
    func getStarRailEquipmentList() -> Any
    func getSkillCompute(id: String) -> StarRailSkillComputeModel
    func getSkillRogue(id: String) -> Any
    func getSkillChallenge(id: String) -> Any

    func getStarRailAllRoleList() -> StarRailAllRoleModel
    func getRoleInfo(id: String) -> StarRailRoleInfoModel
}

struct HeadersModel {
    struct DSInfo {
        static let version = "2.60.1"
        static let k2Key = "K2"
        static let lk2Key = "LK2"
        static let key22 = "22"
        static let key25 = "25"
        static let osKey = "os"
        static let pdKey = "pd"

        static let config: [String: Any] = [
            version: [
                DSInfo.k2Key: "AcpNVhfh0oedCobdCyFV8EE1jMOVDy9q",
                DSInfo.lk2Key: "1OJyMNCqFlstEQqqMOv0rKCIdTOoJhNt",
                DSInfo.key22: "t0qEgfub6cvueAPgR5m9aQWWVciEer7v",
                DSInfo.key25: "xV8v4Qu54lUKrEYFZkJhB8cuOh9Asafs",
            ],
            DSInfo.osKey: "6cqshh5dhw73bzxn20oexa9k516chk7s",
            DSInfo.pdKey: "JwYDpKvLj6MrMqqYU6jTKF17KNO2PXoS"
        ]
    }
    
    var ds: String = ""
    var appVersion: String = "2.19.1"
    var clientType: String = "5"
    var language: String = "zh-cn"
    var referer: String = "https://webstatic.mihoyo.com/"
    var cookie: String = ""
    var accept: String = "application/json, text/plain, */*"
    var contentTyoe: String = "application/x-www-form-urlencoded;charset=UTF-8"
    var acceptEncoding: String = "gzip, deflate, br"
    var acceptLanguage: String = "zh-CN,zh-Hans;q=0.9"
    
    init(uid: String, region: String, cookie: String) {
        let timestamp = Int(Date().timeIntervalSince1970)
        let random = Int.random(in: 100000...200000)
        
        _ = "salt=xV8v4Qu54lUKrEYFZkJhB8cuOh9Asafs&t=\(timestamp)&r=\(random)&b=&q=role_id=\(uid)&server=\(region)".md5()

        self.ds = RequestHeader().getDSToken(b: ["server": "\(region)",
                                                 "role_id": "\(uid)"])//"\(timestamp),\(random),\(sign)"
        self.cookie = cookie
    }
    
    func getHeaders() -> HTTPHeaders {
        HTTPHeaders([
            "DS": ds,
            "x-rpc-app_version": appVersion,
            "x-rpc-client_type": clientType,
            "x-rpc-language": language,
            "Referer": referer,
            "Cookie": cookie,
            "Accept": accept,
            "Content-Tyoe": contentTyoe,
            "Accept-Encoding": acceptEncoding,
            "Accept-Language": acceptLanguage,
            "x-rpc-sys_version": "17.3.1",
            "x-rpc-device_id": "AFA5DBD7-D027-402B-9522-1D9A4A5EFB85",
            "x-rpc-tool_verison": "v2.0.2",
            "x-rpc-page": "v2.0.2_#/rpg/roles",
            "x-rpc-device_name": "iPhone",
            "Origin": "https://webstatic.mihoyo.com",
            "x-rpc-platform": "5",
            "Sec-Fetch-Dest": "empty",
            "Sec-Fetch-Site": "same-site",
            "Sec-Fetch-Mode": "cors",
            "x-rpc-device_fp": "38d7f349e93d8",
            "User-Agent": "Mozilla/5.0 (iPhone; CPU iPhone OS 17_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) miHoYoBBS/2.68.1"
        ])
    }
}
