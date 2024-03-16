//
//  SQLManagerHelper.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation

class SQLManagerHelper {
    static func saveMihoyoUser(
        userInfo: MihoyoUserInfo,
        complete: @escaping (Bool, Error?) -> Void
    ) {
        SQLManager.shared.getMihoyoUser(userInfo.uid) { _, user in
            if user == nil {
                SQLManagerHelper.addMihoyoUser(userInfo, complete: complete)
            } else {
                SQLManagerHelper.upgradeMihoyoUser(userInfo, complete: complete)
            }
        }
    }
    
    static func getMihoyoUser(
        uid: String,
        complete: @escaping (MihoyoUserInfo) -> Void
    ) {
        SQLManager.shared.getMihoyoUser(uid) { _, user in
            guard let user = user else {
                return
            }
            complete(user)
        }
    }
    
    private static func addMihoyoUser(
        _ userInfo: MihoyoUserInfo,
        complete: @escaping (Bool, Error?) -> Void
    ) {
        SQLManager.shared.addMihoyoUser(userInfo) { success, error in
            complete(success, error)
        }
    }
    
    private static func upgradeMihoyoUser(
        _ userInfo: MihoyoUserInfo,
        complete: @escaping (Bool, Error?) -> Void
    ) {
        SQLManager.shared.upgradeMihoyoUser(
            userInfo.uid,
            model: userInfo
        ) { success, error in
            complete(success, error)
        }
    }

    static func saveMihoyoGameCards(
        _ uid: String,
        gameCards: [MihoyoGameCardsList]
    ) {
        let gameCards = SQLManager.shared.getAllMihoyoGameCards(uuid: uid)
        
        if gameCards.isEmpty {
            SQLManager.shared.addMihoyoGameCards(
                uuid: uid,
                model: gameCards
            ) { _, error in
                if let error {
                    Logger.error(error)
                }
            }
        } else {
            SQLManager.shared.upgradeMihoyoGameCards(
                uuid: uid,
                model: gameCards
            ) { _, error in
                if let error {
                    Logger.error(error)
                }
            }
        }
    }
}

extension SQLManagerHelper {
    static func saveStarRailWidget(uid: String, model: StarRailWidgetDataModel) {
        SQLManager.shared.getStarRailRoleDailyNode(uid) { _, item in
            if item == nil {
                SQLManagerHelper.addStarRailWidget(uid: uid, model: model)
            } else {
                SQLManagerHelper.upgradeStarRailWidget(uid: uid, model: model)
            }
        }
    }
    
    static func addStarRailWidget(uid: String, model: StarRailWidgetDataModel) {
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
    
    static func upgradeStarRailWidget(uid: String, model: StarRailWidgetDataModel) {
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

extension SQLManagerHelper {
    static func fetchStarRailRoleDetail(uid: String, list: [StarRailAllRoleListModel]) {
        for role in list {
            SQLManager.shared.getStarRailRoleInfo(
                uid, roleID: role.itemID ?? ""
            ) { _, item in
                if item != nil {
                    SQLManagerHelper.upgradeStarRailRoleInfo(uid: uid, role: role)
                } else {
                    SQLManagerHelper.saveStarRailRoleInfo(uid: uid, role: role)
                }
            }
            
//            fetchStarRailRoleSkill(
//                uid: uid,
//                roleID: role.itemID ?? ""
//            )
//            self?.fetchStarRailRoleSkillCompute(
//                uid: uid,
//                roleID: role.itemID ?? ""
//            )
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

extension SQLManagerHelper {
    static func saveStarRailRoleSkill(
        uid: String,
        roleID: String,
        info: StarRailRoleInfoData
    ) {
        SQLManager.shared.getStarRailRoleSkills(uid, roleID: roleID) { _, item in
            if item != nil {
                SQLManagerHelper.upgradeStarRailRoleSkill(uid: uid, info: info)
            } else {
                SQLManagerHelper.addStarRailRoleSkill(uid: uid, info: info)
            }
        }
    }
    
    static func addStarRailRoleSkill(
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

extension SQLManagerHelper {
    static func saveStarRailRole(
        uid: String,
        roleID: String,
        info: StarRailSkillComputeData
    ) {
        SQLManager.shared.getStarRailRoleCompute(
            uid, roleID: roleID
        ) { _, item in
            if item != nil {
                SQLManagerHelper.upgradeStarRailRoleCompute(uid: uid, roleID: roleID, info: info)
            } else {
                SQLManagerHelper.addStarRailRoleCompute(uid: uid, roleID: roleID, info: info)
            }
        }
    }
    
    static func addStarRailRoleCompute(
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
