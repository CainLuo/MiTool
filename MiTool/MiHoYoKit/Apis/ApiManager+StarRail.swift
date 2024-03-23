//
//  ApiManager+StarRail.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Alamofire
import Combine
import ObjectMapper

extension ApiManager {
    func fetchStarRailGameRoleInfo<T: Mappable>(with parameters: [String: Any]) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.takumi.rawValue + ApiKeys.Mihoyo.gameRoles.rawValue
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
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
//        { (result: Result<StarRailWidgetModel, Error>) in
//            switch result {
//            case .success(let success):
//                guard let data = success.data else {
//                    return
//                }
//                Logger.info(data)
//            case .failure(let failure):
//                Logger.error(failure)
//            }
//        }
    }
    
    func fetchStarRailWidget<T: Mappable>(with
        uid: String,
        server: Region = .china
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.widget.rawValue
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
            parameters: nil,
            headers: HTTPHeaders(headers)
        )
//        { (result: Result<StarRailWidgetModel, Error>) in
//            switch result {
//            case .success(let success):
//                guard let data = success.data else {
//                    return
//                }
//                SQLManagerHelper.saveStarRailWidget(uid: uid, model: data)
//                completion(data)
//            case .failure(let failure):
//                Logger.error(failure)
//            }
//        }
    }

    func fetchStarRailRoles<T: Mappable>(with
        uid: String,
        parameters: Parameters,
        server: Region = .china
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.widget.rawValue
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
            parameters: nil,
            headers: HTTPHeaders(headers)
        )
//        { (result: Result<StarRailAllRoleModel, Error>) in
//            switch result {
//            case .success(let success):
//                guard let list = success.data?.list else {
//                    return
//                }
//                SQLManagerHelper.fetchStarRailRoleDetail(uid: uid, list: list)
//            case .failure(let failure):
//                Logger.error(failure)
//            }
//        }
    }

    func fetchStarRailRoleSkill<T: Mappable>(with
        uid: String,
        roleID: String,
        server: Region = .china
    ) -> AnyPublisher<T, Never> {
        let parameters: Parameters = ["game": "hkrpg",
                                      "lang": "zh-cn",
                                      "item_id": roleID,
                                      "tab_from": "TabAll",
                                      "change_target_level": 0,
                                      "uid": uid,
                                      "region": "prod_gf_cn"]
        
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.widget.rawValue
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
        
        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
//        { (result: Result<StarRailRoleInfoModel, Error>) in
//            switch result {
//            case .success(let success):
//                guard let info = success.data else {
//                    return
//                }
//                SQLManagerHelper.saveStarRailRoleSkill(uid: uid, roleID: roleID, info: info)
//            case .failure(let failure):
//                Logger.error(failure)
//            }
//        }
    }

    func fetchStarRailRoleSkillCompute<T: Mappable>(with
        uid: String,
        roleID: String,
        server: Region = .china,
        deviceFP: String,
        deviceID: String
    ) -> AnyPublisher<T, Never> {
        let parameters: Parameters = [
            "game": "hkrpg",
            "lang": "zh-cn",
            "item_id": roleID,
            "tab_from": "TabAll",
            "change_target_level": 0,
            "uid": uid,
            "region": "prod_gf_cn"
        ]
        
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.widget.rawValue
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
        
        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
//        { (result: Result<StarRailSkillComputeModel, Error>) in
//            switch result {
//            case .success(let success):
//                guard let info = success.data else {
//                    return
//                }
//                SQLManagerHelper.saveStarRailRole(uid: uid, roleID: roleID, info: info)
//            case .failure(let failure):
//                Logger.error(failure)
//            }
//        }
    }
}
