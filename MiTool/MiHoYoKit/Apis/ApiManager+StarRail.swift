//
//  ApiManager+StarRail.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Alamofire

extension ApiManager {
    func fetchStarRailWidget(
        uid: String,
        parameters: Parameters,
        server: Region = .china,
        completion: @escaping (Result<StarRailWidgetModel, Error>) -> Void
    ) {
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
        
        get(
            url: url,
            parameters: nil,
            headers: HTTPHeaders(headers)
        ) { (result: Result<StarRailWidgetModel, Error>) in
            switch result {
            case .success(let success):
                guard let data = success.data else {
                    return
                }
                SQLManagerHelper.saveStarRailWidget(uid: uid, model: data)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }

    func fetchStarRailRoles(
        uid: String,
        parameters: Parameters,
        server: Region = .china,
        completion: @escaping (Result<StarRailAllRoleModel, Error>) -> Void
    ) {
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
        
        get(
            url: url,
            parameters: nil,
            headers: HTTPHeaders(headers)
        ) { (result: Result<StarRailAllRoleModel, Error>) in
            switch result {
            case .success(let success):
                guard let list = success.data?.list else {
                    return
                }
                SQLManagerHelper.fetchStarRailRoleDetail(uid: uid, list: list)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }

    func fetchStarRailRoleSkill(
        uid: String,
        roleID: String,
        server: Region = .china,
        completion: @escaping (Result<StarRailRoleInfoModel, Error>) -> Void
    ) {
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
        
        get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        ) { (result: Result<StarRailRoleInfoModel, Error>) in
            switch result {
            case .success(let success):
                guard let info = success.data else {
                    return
                }
                SQLManagerHelper.saveStarRailRoleSkill(uid: uid, roleID: roleID, info: info)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }

    func fetchStarRailRoleSkillCompute(
        uid: String,
        roleID: String,
        server: Region = .china,
        deviceFP: String,
        deviceID: String,
        completion: @escaping (Result<StarRailSkillComputeModel, Error>) -> Void
    ) {
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
        
        get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        ) { (result: Result<StarRailSkillComputeModel, Error>) in
            switch result {
            case .success(let success):
                guard let info = success.data else {
                    return
                }
                SQLManagerHelper.saveStarRailRole(uid: uid, roleID: roleID, info: info)
            case .failure(let failure):
                Logger.error(failure)
            }
        }
    }
}
