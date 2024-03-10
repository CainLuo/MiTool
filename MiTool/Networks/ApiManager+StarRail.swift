//
//  ApiManager+StarRail.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/10.
//

import Foundation

extension ApiManager {
    static func fetchStarRailRoles(
        uid: String,
        complete: ((Bool, [StarRailAllRoleListModel]) -> Void)?
    ) {
        let model = api().getStarRailAllRoleList()
        
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
            debugPrint("Save role info success")
        }
    }
    
    static func upgradeStarRailRoleInfo(uid: String, role: StarRailAllRoleListModel) {
        SQLManager.shared.upgradeStarRailRoleInfo(
            uuid: uid, model: role
        ) {  _, error in
            guard error == nil else {
                return
            }
            debugPrint("Upgrade role info success")
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
            debugPrint("Save role Skill success")
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
            debugPrint("Upgrade role Skill success")
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
            debugPrint("Save role Compute success")
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
            debugPrint("Upgrade role Compute success")
        }
    }
}
