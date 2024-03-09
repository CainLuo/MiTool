//
//  ApiProtocol.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import Alamofire
import CryptoSwift

protocol ApiProtocol {
    // MARK: - Mihoyo User
    func getMihoyoUserInfo() -> MihoyoUserModel
    func getMihoyoGameCards() -> MihoyoGameCardsModel

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
    enum DSInfo: String {
        case version = "2.60.1"
        case k2Key = "K2"
        case lk2Key = "LK2"
        case key22 = "22"
        case key25 = "25"
        case osKey = "os"
        case pdKey = "pd"
    }

    let config: [String: Any] = [
        DSInfo.version.rawValue: [
            DSInfo.k2Key: "AcpNVhfh0oedCobdCyFV8EE1jMOVDy9q",
            DSInfo.lk2Key: "1OJyMNCqFlstEQqqMOv0rKCIdTOoJhNt",
            DSInfo.key22: "t0qEgfub6cvueAPgR5m9aQWWVciEer7v",
            DSInfo.key25: "xV8v4Qu54lUKrEYFZkJhB8cuOh9Asafs"
        ],
        DSInfo.osKey.rawValue: "6cqshh5dhw73bzxn20oexa9k516chk7s",
        DSInfo.pdKey.rawValue: "JwYDpKvLj6MrMqqYU6jTKF17KNO2PXoS"
    ]

    var decodeSalt: String = ""
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
//        let timestamp = Int(Date().timeIntervalSince1970)
//        let random = Int.random(in: 100000...200000)
//        _ = "salt=xV8v4Qu54lUKrEYFZkJhB8cuOh9Asafs&t=\(timestamp)&r=\(random)&b=&q=role_id=\(uid)&server=\(region)".md5()
        let body = [
            "server": "\(region)",
            "role_id": "\(uid)"
        ]
        self.decodeSalt = RequestHeader().getDSToken(body: body)
        self.cookie = cookie
    }

    func getHeaders() -> HTTPHeaders {
        HTTPHeaders([
            "DS": decodeSalt,
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
