//
//  ApiManager+Genshin.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Alamofire
import Combine
import ObjectMapper

extension ApiManager {
    func fetchGenshinWidget<T: Mappable>(
        uid: String
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.takumiRecord.rawValue + ApiKeys.GenshinImpact.widget.rawValue
        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: ""
        )
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": cookie + "stoken=\(sToken)",
                "x-rpc-device_fp": deviceFP,
                "x-rpc-device_id": deviceID
            ]
        )
        
        return get(
            url: url,
            parameters: nil,
            headers: HTTPHeaders(headers)
        )
    }
    
    func fetchGenshinCharacter<T: Mappable>(
        with uid: String,
        roleRegion: String
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.takumiRecord.rawValue + ApiKeys.GenshinImpact.character.rawValue
        let parameters: Parameters = [
            "role_id": uid,
            "server": roleRegion
        ]
        
        guard let body = parameters.toJSONString?.removeNewlinesAndSpaces() else {
            fatalError("Invalid body: \(parameters)")
        }

        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: "",
            body: body
        )
        
        let headers = [
            "DS": decodeSalt,
            "Cookie": cookie,
            "x-rpc-device_fp": deviceFP,
            "x-rpc-device_id": deviceID,
            "x-rpc-client_type": "5",
            "x-rpc-app_version": "2.60.1",
            "x-requested-with": "com.mihoyo.hyperion",
            "referer": "https://webstatic.mihoyo.com"
        ]

        return post(
            url: url,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(headers)
        )
    }
    
    func fetchGenshinRoleSkills<T: Mappable>(
        gameUID: String, 
        roleRegion: String,
        avatarID: Int
    ) -> AnyPublisher<T, Never> {
        var accountID = ""
        let strings = cookie.components(separatedBy: ";")
        let stuids = strings.filter { $0.contains("stuid=") }
        if let uidString = stuids.first {
            let uid = uidString.replacingOccurrences(of: "stuid=", with: "")
            accountID = "account_id=\(uid)"
        }
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.GenshinImpact.roleDetail.rawValue
        let parameters: Parameters = [
            "uid": gameUID,
            "region": roleRegion,
            "avatar_id": avatarID
        ]
        let headers = [
            "Cookie": "\(accountID);cookie_token=\(cookieToken)",
            "referer": "https://webstatic.mihoyo.com"
        ]
        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
    }
    
    func fetchGensinWeaponList<T: Mappable>(page: Int) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.GenshinImpact.weapons.rawValue
        let parameters: Parameters = [
            "weapon_cat_ids": [],
            "weapon_levels": [],
            "page": page,
            "size": 20
        ]
                
        let headers = ApiHeaderConfiguration.baseHeaders(
            region: region,
            additionalHeaders: ["Cookie": cookie]
        )
        
        return post(
            url: url,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(headers)
        )
    }
    
    func fetchGensinWeaponCompute<T: Mappable>(
        weaponID: Int, 
        currentLevel: Int = 1,
        targetLevel: Int = 90
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.GenshinImpact.compute.rawValue
        let parameters: Parameters = [
            "weapon": [
                "id": weaponID,
                "level_current": currentLevel,
                "level_target": targetLevel
            ],
            "reliquary_list": []
        ]
                
        let headers = ApiHeaderConfiguration.baseHeaders(
            region: region,
            additionalHeaders: ["Cookie": cookie]
        )
        
        return post(
            url: url,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: HTTPHeaders(headers)
        )
    }
}
