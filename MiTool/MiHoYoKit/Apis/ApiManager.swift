//
//  ApiManager.swift
//  MiTool
//
//  Created by Cain on 2024/3/5.
//

import Foundation
import Alamofire

class ApiManager: BaseRequestable {
    static let shared = ApiManager()
    
    var deviceFP: String = ""
    var deviceID: String = ""
    var region: Region = .china
    var cookie: String = ""
    var sToken: String = ""

    private init() { }
    
    func fetchMihoyoUserInfo(
        uid: String,
        region: Region = .china,
        completion: @escaping (MihoyoUserInfo) -> Void
    ) {
        let url = ApiKeys.Host.bbsMihoyo.rawValue + ApiKeys.Mihoyo.userFullInfo.rawValue
        let parameters: Parameters = ["uid": uid]
        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: ""
        )
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": cookie,
                "x-rpc-device_fp": deviceFP,
                "x-rpc-device_id": deviceID
            ]
        )
        
        get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        ) { (result: Result<MihoyoUserModel, Error>) in
            switch result {
            case .success(let success):
                guard let userInfo = success.data?.userInfo else {
                    return
                }
                completion(userInfo)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }
    
    /// Get MiHoYo User Game Cards
    /// - Parameters:
    ///   - uid: MiHoYo user id
    ///   - completion: completion: @escaping (Result<MihoyoGameCardsModel, Error>) -> Void
    func fetchMihoyoGameCards(
        uid: String
    ) {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.Mihoyo.gameRecord.rawValue
        let parameters: Parameters = ["uid": uid]
        let decodeSalt = ApiDSHelper.getDS1()
        let headers = [
            "Referer": "https://webstatic.mihoyo.com",
            "DS": decodeSalt,
            "Cookie": cookie + "stoken=\(sToken)",
            "x-rpc-device_fp": deviceFP,
            "x-rpc-device_id": deviceID,
            "x-rpc-client_type": "2",
            "x-rpc-app_version": "2.63.1"
        ]

        get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        ) { (result: Result<MihoyoGameCardsModel, Error>) in
            switch result {
            case .success(let success):
                guard let list = success.data?.list else {
                    return
                }
                SQLManagerHelper.saveMihoyoGameCards(uid, gameCards: list)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }
    
    /// Get MiHoYo User Game Cards
    /// - Parameters:
    ///   - uid: MiHoYo user id
    ///   - completion: completion: @escaping (Result<MihoyoGameCardsModel, Error>) -> Void
    func fetchStarRailGameCards(
        uid: String,
        server: String
    ) {
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.Mihoyo.gameRoles.rawValue
        let parameters: Parameters = ["game_biz": server]
        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: ""
        )
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": cookie,
                "x-rpc-device_fp": deviceFP,
                "x-rpc-device_id": deviceID
            ]
        )

        get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        ) { (result: Result<MihoyoGameCardsModel, Error>) in
            switch result {
            case .success(let success):
                guard let list = success.data?.list else {
                    return
                }
                SQLManagerHelper.saveStarRailCards(uid, gameCards: list)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }

    /// Get Genshin User Game Cards
    /// - Parameters:
    ///   - uid: MiHoYo user id
    ///   - completion: completion: @escaping (Result<MihoyoGameCardsModel, Error>) -> Void
    func fetchGenshinGameCards(
        uid: String
    ) {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.Mihoyo.gameRecord.rawValue
        let parameters: Parameters = ["uid": uid]
        let decodeSalt = ApiDSHelper.getDS1()
        let headers = [
            "Referer": "https://webstatic.mihoyo.com",
            "DS": decodeSalt,
            "Cookie": cookie + "stoken=\(sToken)",
            "x-rpc-device_fp": deviceFP,
            "x-rpc-device_id": deviceID,
            "x-rpc-client_type": "2",
            "x-rpc-app_version": "2.63.1"
        ]

        get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        ) { (result: Result<MihoyoGameCardsModel, Error>) in
            switch result {
            case .success(let success):
                guard let list = success.data?.list else {
                    return
                }
                SQLManagerHelper.saveMihoyoGameCards(uid, gameCards: list)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }
}
