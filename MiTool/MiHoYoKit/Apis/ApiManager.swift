//
//  ApiManager.swift
//  MiTool
//
//  Created by Cain on 2024/3/5.
//

import Foundation
import Alamofire
import Combine
import ObjectMapper

class ApiManager: BaseApiManager {
    static let shared = ApiManager()
    
    var deviceFP: String = ""
    var deviceID: String = ""
    var region: Region = .china
    var cookie: String = ""
    var sToken: String = ""

    override init() {
        super.init()
    }
    
    func fetchMihoyoUserInfo<T: Mappable>(
        uid: String,
        region: Region = .china
    ) -> AnyPublisher<T, Never> {
        let urlString = ApiKeys.Host.bbsMihoyo.rawValue + ApiKeys.Mihoyo.userFullInfo.rawValue
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }

        let parameters: Parameters = ["uid": uid]
        let decodeSalt = ApiDSHelper.getDS(region: region, query: "")
        
        let additionalHeader = [
            "DS": decodeSalt,
            "Cookie": cookie,
            "x-rpc-device_fp": deviceFP,
            "x-rpc-device_id": deviceID
        ]

        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: additionalHeader
        )
        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
    }
    
    func fetchStarRailGameCards<T: Mappable>(
        uid: String,
        server: String
    ) -> AnyPublisher<T, Never> {
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
        
        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
    }
    
    /// Get Genshin User Game Cards
    /// - Parameters:
    ///   - uid: MiHoYo user id
    ///   - completion: completion: @escaping (Result<MihoyoGameCardsModel, Error>) -> Void
    func fetchGenshinGameCards<T: Mappable>(
        uid: String
    ) -> AnyPublisher<T, Never> {
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

        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
//        { (result: Result<MihoyoGameCardsModel, Error>) in
//            switch result {
//            case .success(let success):
//                guard let list = success.data?.list else {
//                    return
//                }
//                SQLManagerHelper.saveMihoyoGameCards(uid, gameCards: list)
//            case .failure(let failure):
//                Logger.error(failure)
//            }
//        }
    }
    
    /// Get MiHoYo User Game Cards
    /// - Parameters:
    ///   - uid: MiHoYo user id
    ///   - completion: completion: @escaping (Result<MihoyoGameCardsModel, Error>) -> Void
    func fetchMihoyoGameCards<T: Mappable>(
        uid: String
    ) -> AnyPublisher<T, Never> {
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

        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
    }
}
