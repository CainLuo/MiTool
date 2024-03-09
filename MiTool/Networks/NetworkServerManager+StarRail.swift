//
//  NetworkServerManager+StarRail.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/10.
//

import Foundation

extension NetworkServerManager {
    static func fetchStarRailRoles(
        uid: String,
        complete: ((Bool, [StarRailAllRoleListModel]) -> Void)?
    ) {
        let model = api().getStarRailAllRoleList()
        
        guard let list = model.data?.list else {
            return
        }
        
        complete?(true, list)
        
        var tempRoleList: [StarRailAllRoleListModel] = []
        
        for role in list {
            SQLManager.shared.addStarRailRoleInfo(
                uuid: uid,
                model: role
            ) {  _, error in
                guard error == nil else {
                    tempRoleList.append(role)
                    return
                }
                debugPrint("Save role info success")
            }
            
            fetchStarRailRoleDetail(
                uid: uid,
                roleID: role.itemID ?? ""
            )
            fetchStarRailRoleSkillCompute(
                uid: uid,
                roleID: role.itemID ?? ""
            )
        }
    }
    
    static func fetchStarRailRoleDetail(
        uid: String,
        roleID: String
    ) {
        let model = api().getRoleInfo(id: roleID)
        
        guard let info = model.data else {
            return
        }
        
        SQLManager.shared.addStarRailRoleSkillInfo(
            uuid: uid,
            model: info) { success, error in
                guard error == nil else {
                    return
                }
                debugPrint("Save role info success")
            }
    }
    
    static func fetchStarRailRoleSkillCompute(
        uid: String, 
        roleID: String
    ) {
        let model = api().getSkillCompute(id: roleID)
        
        guard let info = model.data else {
            return
        }

        SQLManager.shared.addStarRailRoleComputeInfo(
            uuid: uid,
            roleID: roleID,
            model: info
        ) { success, error in
            guard error == nil else {
                return
            }
            debugPrint("Save role info success")
        }
    }
}
