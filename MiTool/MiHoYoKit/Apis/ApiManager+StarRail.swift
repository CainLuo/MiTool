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
    
    func fetchStarRailCharacter<T: Mappable>(
        with uid: String,
        server: String
    ) -> AnyPublisher<T, Never> {
        let url = ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.character.rawValue
        let parameters: Parameters = [
            "rolePageAccessNotAllowed": "",
            "role_id": "102731382",
            "server": "prod_gf_cn"
        ]
        
        guard let body = parameters.toJSONString?.removeNewlinesAndSpaces() else {
            fatalError("Invalid body: \(parameters)")
        }
//    https://api-takumi-record.mihoyo.com/game_record/app/hkrpg/api/avatar/basic
//    https://api-takumi-record.mihoyo.com/game_record/app/hkrpg/api/avatar/basic?rolePageAccessNotAllowed=&role_id=102731382&server=prod_gf_cn

        let decodeSalt = ApiDSHelper.getDS(
            region: region,
            query: "",
            body: body
        )
//        let decodeSalt = ApiDSHelper.getDS(method: "POST", data: "{\"role_id\":\"109050292\",\"server\":\"cn_gf01\"}")
        
        // swiftlint:disable line_length
        let cookie = """
_ga=GA1.2.678142620.1702975345; _gid=GA1.2.824444971.1711102266; _MHYUUID=49c60b95-ff7c-4cd3-baf9-ca5ec2e8bcd5; account_id=182692936; cookie_token=JehTWNlBuzMaJquN7YZtTumPzheRcDuGVMCTlZH5; login_ticket=dqY0SCsvLuYnuPwmjIYewsgpcCTVltR4IgOu9GGK; ltoken=ZTwWusQfepBrz3m9NtJiAplUmaChRb9n4NanTohR; ltuid=182692936; acw_tc=ac11000117112580040866314e32e647b08174d6a2ae7d3848377727318b60; aliyungf_tc=83cfe4e0678980e4302fdeb41930ad205c0516ab9f8749625639564aeb28df85; DEVICEFP=38d7f723f1b84; DEVICEFP_SEED_ID=6c84f2c1e38190ee; DEVICEFP_SEED_TIME=1703000160066; mi18nLang=zh-cn; _ga_TNHTCPX54K=GS1.1.1711102511.2.1.1711102528.0.0.0; _ga_MRQ1MZMMEE=GS1.1.1711102497.80.0.1711102504.0.0.0; e_hkrpg_token=OHFDjJhV+O74frBc+YnOJyuWGibwMQlBUHgb8kK6VKoLXEnfqU8VglvtgwwSeQoB; _ga_J1K3VE5FNG=GS1.1.1711102292.79.0.1711102292.0.0.0; _ga_HB2EBLW929=GS1.1.1711102291.79.0.1711102291.0.0.0; _ga_K2F0P1NR6Z=GS1.1.1710317160.43.0.1710317160.0.0.0; _ga_00MJSJTX01=GS1.1.1710230056.21.0.1710230128.0.0.0; _ga_ZY0YM68HK0=GS1.1.1710004179.2.0.1710004179.0.0.0; _ga_DNM1PJ22XW=GS1.1.1709805303.24.1.1709805343.0.0.0; _ga_H728700W1R=GS1.1.1709805303.25.1.1709805343.0.0.0; _ga_9TTX3TE5YL=GS1.1.1709393878.8.1.1709393878.0.0.0; _ga_M91EY72BM9=GS1.1.1709393874.11.0.1709393874.0.0.0; _ga_BGFQM8L1FY=GS1.1.1707554216.2.1.1707554506.0.0.0; _ga_CK6RQZ7Y8C=GS1.1.1707220737.1.1.1707220790.0.0.0; _ga_PQGG2CR601=GS1.1.1707220737.1.1.1707220790.0.0.0; _ga_29PCTL5P98=GS1.1.1706512250.1.0.1706512253.0.0.0; _ga_CXN1FSHKS4=GS1.1.1706512250.1.0.1706512253.0.0.0; _ga_6C02QT42ND=GS1.1.1706015187.4.1.1706015318.0.0.0; _ga_V9SNDVD3W5=GS1.1.1705731012.2.0.1705731012.0.0.0; _ga_9P3EH988KE=GS1.1.1705115296.2.0.1705115300.0.0.0; _ga_C3RWQNGX77=GS1.1.1705115296.2.0.1705115299.0.0.0; _ga_YRXCBL5X3B=GS1.1.1704385030.1.0.1704385033.0.0.0; _ga_FKNT4WRGY4=GS1.1.1704211064.2.0.1704211139.0.0.0; _ga_D2HF9XKYED=GS1.1.1703944274.2.1.1703944348.0.0.0
"""
        // swiftlint:enable line_length

        let headers = ApiHeaderConfiguration.defaultHeaders(
            region: region,
            additionalHeaders: [
                "DS": decodeSalt,
                "Cookie": cookie,
                "x-rpc-device_fp": deviceFP,
                "x-rpc-device_id": deviceID,
                "x-rpc-platform": "5"
            ])

        return get(
            url: url,
            parameters: parameters,
            headers: HTTPHeaders(headers)
        )
    }
}
