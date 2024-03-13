//
//  ApiManager+StarRail.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/10.
//

import Foundation
import Alamofire

extension ApiManager {
    static func fetchStarRailWidget(
        uid: String,
        serverType: StarRailServerType
    ) -> StarRailWeightDataModel? {
        let parameters = ["server": "prod_gf_cn",
                          "role_id": "102731382"]
        let ds = ApiDSHelper.getDS(region: .china, query: parameters.toJSONString ?? "")
        let headers = ApiHeaderConfiguration.defaultHeaders(region: .china, additionalHeaders: ["DS": ds])
        
        NetworkManager<StarRailWeightModel>().get(
            from: ApiKeys.StarRail.dailyNote.rawValue,
            host: ApiKeys.Host.mihoyo.rawValue, scheme: "https",
            headers: HTTPHeaders(headers),
            parameters: parameters) { result in
                switch result {
                case .success(let success):
                    break
                case .failure(let failure):
                    break
                }
            }
        
        return nil
    }
    
    private static func saveStarRailWidget(uid: String, model: StarRailWeightDataModel) {
        SQLManager.shared.getStarRailRoleDailyNode(uid) { _, item in
            if item == nil {
                ApiManager.addStarRailWidget(uid: uid, model: model)
            } else {
                ApiManager.upgradeStarRailWidget(uid: uid, model: model)
            }
        }
    }
    
    private static func addStarRailWidget(uid: String, model: StarRailWeightDataModel) {
        SQLManager.shared.addStarRailDailyNode(
            uid,
            model: model
        ) { _, error in
            guard error == nil else {
                return
            }
            Logger.info("Upgrade role info success")
        }
    }
    
    private static func upgradeStarRailWidget(uid: String, model: StarRailWeightDataModel) {
        SQLManager.shared.upgradeStarRailDailyNode(
            uid,
            model: model
        ) { _, error in
            guard error == nil else {
                return
            }
            Logger.info("Upgrade role info success")
        }
    }
}

extension ApiManager {
    static func fetchStarRailRoles(
        uid: String,
        complete: ((Bool, [StarRailAllRoleListModel]) -> Void)?
    ) {
        let model = api().getStarRailMyRoleList()
        
        guard let list = model.data?.list else {
            return
        }
        
        complete?(true, list)
                
        for role in list {
            SQLManager.shared.getStarRailRoleInfo(
                uid, roleID: role.itemID ?? ""
            ) { _, item in
                if item != nil {
                    ApiManager.upgradeStarRailRoleInfo(uid: uid, role: role)
                } else {
                    ApiManager.saveStarRailRoleInfo(uid: uid, role: role)
                }
            }
            
            fetchStarRailRoleSkill(
                uid: uid,
                roleID: role.itemID ?? ""
            )
            fetchStarRailRoleSkillCompute(
                uid: uid,
                roleID: role.itemID ?? ""
            )
        }
    }
    
    static func saveStarRailRoleInfo(uid: String, role: StarRailAllRoleListModel) {
        SQLManager.shared.addStarRailRoleInfo(
            uuid: uid,
            model: role
        ) {  _, error in
            guard error == nil else {
                return
            }
            Logger.info("Save role info success")
        }
    }
    
    static func upgradeStarRailRoleInfo(uid: String, role: StarRailAllRoleListModel) {
        SQLManager.shared.upgradeStarRailRoleInfo(
            uuid: uid, model: role
        ) {  _, error in
            guard error == nil else {
                return
            }
            Logger.info("Upgrade role info success")
        }
    }
}

// MARK: - Honkai: StarRail Role Skills
extension ApiManager {
    static func fetchStarRailRoleSkill(
        uid: String,
        roleID: String
    ) {
        let model = api().getRoleInfo(id: roleID)
        
        guard let info = model.data else {
            return
        }
        
        SQLManager.shared.getStarRailRoleSkills(uid, roleID: roleID) { _, item in
            if item != nil {
                ApiManager.upgradeStarRailRoleSkill(uid: uid, info: info)
            } else {
                ApiManager.saveStarRailRoleSkill(uid: uid, info: info)
            }
        }
    }
    
    static func saveStarRailRoleSkill(
        uid: String, 
        info: StarRailRoleInfoData
    ) {
        SQLManager.shared.addStarRailRoleSkillInfo(
            uuid: uid,
            model: info
        ) { _, error in
            guard error == nil else {
                return
            }
            Logger.info("Save role Skill success")
        }
    }
    
    static func upgradeStarRailRoleSkill(
        uid: String,
        info: StarRailRoleInfoData
    ) {
        SQLManager.shared.upgradeStarRailRoleSkillInfo(
            uuid: uid,
            model: info
        ) { _, error in
            guard error == nil else {
                return
            }
            Logger.info("Upgrade role Skill success")
        }
    }
}

// MARK: - Honkai: StarRail Role Compute
extension ApiManager {
    static func fetchStarRailRoleSkillCompute(
        uid: String,
        roleID: String
    ) {
        let model = api().getSkillCompute(id: roleID)
        
        guard let info = model.data else {
            return
        }
        
        SQLManager.shared.getStarRailRoleCompute(
            uid, roleID: roleID
        ) { _, item in
            if item != nil {
                ApiManager.upgradeStarRailRoleCompute(uid: uid, roleID: roleID, info: info)
            } else {
                ApiManager.saveStarRailRoleCompute(uid: uid, roleID: roleID, info: info)
            }
        }
    }
    
    static func saveStarRailRoleCompute(
        uid: String,
        roleID: String,
        info: StarRailSkillComputeData
    ) {
        SQLManager.shared.addStarRailRoleComputeInfo(
            uuid: uid,
            roleID: roleID,
            model: info
        ) { _, error in
            guard error == nil else {
                return
            }
            Logger.info("Save role Compute success")
        }
    }
    
    static func upgradeStarRailRoleCompute(
        uid: String,
        roleID: String,
        info: StarRailSkillComputeData
    ) {
        SQLManager.shared.upgradeStarRailRoleComputeInfo(
            uuid: uid,
            roleID: roleID,
            model: info
        ) { _, error in
            guard error == nil else {
                return
            }
            Logger.info("Upgrade role Compute success")
        }
    }
}
