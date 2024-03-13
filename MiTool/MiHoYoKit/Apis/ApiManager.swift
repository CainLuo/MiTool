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
    var server: StarRailServerType = .gdCN
    var cookie: String = ""

    private init() { }
    
    func fetchMihoyoUserInfo(
        uid: String,
        completion: @escaping (Result<MihoyoUserModel, Error>) -> Void
    ) {
        
    }
    
    /// Get MiHoYo User Game Cards
    /// - Parameters:
    ///   - uid: MiHoYo user id
    ///   - completion: completion: @escaping (Result<MihoyoGameCardsModel, Error>) -> Void
    func fetchMihoyoGameCards(
        uid: String,
        completion: @escaping (Result<MihoyoGameCardsModel, Error>) -> Void
    ) {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.Mihoyo.gameRecord.rawValue
        let parameters: Parameters = ["uid": uid]
        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: ""
        )
        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: ["DS": decodeSalt,
                                "Cookie": cookie,
                                "x-rpc-device_fp": deviceFP,
                                "x-rpc-device_id": deviceID]
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
                SQLManagerHelper.saveMihoyoGameCards(uid, gameCards: list)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }
}
