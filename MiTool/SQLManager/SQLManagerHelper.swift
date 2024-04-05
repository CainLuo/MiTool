//
//  SQLManagerHelper.swift
//  MiTool
//
//  Created by Cain on 2024/3/13.
//

import Foundation
import Combine

class SQLManagerHelper {
    var cancellables = Set<AnyCancellable>()
    
    init() {
        // 初始化ViewModel
    }

    deinit {
        cancelSubscriptions()
    }
    
    func cancelSubscriptions() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }

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
        let localCards = SQLManager.shared.getAllMihoyoGameCards(uuid: uid)
        
        if localCards.isEmpty {
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
    static func saveStarRailCards(
        _ uid: String,
        gameCards: [MihoyoGameCardsList]
    ) {
        guard let gameCard = gameCards.first else {
            return
        }
        let localCards = SQLManager.shared.getAllMihoyoGameCards(uuid: uid)
        
        if localCards.isEmpty {
            SQLManager.shared.addStarRailCards(uuid: uid, model: gameCard) { _, error in
                if let error {
                    Logger.error(error)
                }
            }
        } else {
            SQLManager.shared.upgradeStarRailGameCards(uuid: uid, model: gameCard) { _, error in
                if let error {
                    Logger.error(error)
                }
            }
        }
    }

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
    static func saveGenshinCards(
        _ uid: String,
        gameCards: [MihoyoGameCardsList]
    ) {
        guard let gameCard = gameCards.first else {
            return
        }
        let localCards = SQLManager.shared.getAllMihoyoGameCards(uuid: uid)
        
        if localCards.isEmpty {
            SQLManager.shared.addGenshinCards(uuid: uid, model: gameCard) { _, error in
                if let error {
                    Logger.error(error)
                }
            }
        } else {
            SQLManager.shared.upgradeGenshinGameCards(uuid: uid, model: gameCard) { _, error in
                if let error {
                    Logger.error(error)
                }
            }
        }
    }

    static func saveGenshinWidget(uid: String, model: GenshinWidgetData) {
        SQLManager.shared.getStarRailRoleDailyNode(uid) { _, item in
            if item == nil {
                SQLManagerHelper.addGenshinWidget(uid: uid, model: model)
            } else {
                SQLManagerHelper.upgradeGenshinWidget(uid: uid, model: model)
            }
        }
    }
    
    private static func addGenshinWidget(uid: String, model: GenshinWidgetData) {
        SQLManager.shared.addGenshinImpactWidgetInfo(
            uuid: uid,
            model: model
        ) { _, error in
            guard error == nil else {
                return
            }
            Logger.info("Upgrade role info success")
        }
    }
    
    private static func upgradeGenshinWidget(uid: String, model: GenshinWidgetData) {
        SQLManager.shared.updateGenshinImpactWidget(
            uuid: uid,
            model: model
        ) { _, error in
            guard error == nil else {
                return
            }
            Logger.info("Upgrade role info success")
        }
    }
    
    func saveGenshinCharacter(uid: String, model: GenshinCharacterAvatar) {
        guard let avatarID = model.avatarID else {
            return
        }
        SQLManager.shared.getGenshinCharacter(uuid: uid, avatarID: avatarID)
            .sink { item in
                guard item != nil else {
                    SQLManager.shared.addGenshinCharacter(uuid: uid, model: model)
                    return
                }
                SQLManager.shared.upgradeGenshinCharacter(uuid: uid, model: model)
            }
            .store(in: &cancellables)
    }
    
    func saveGenshinSkills(uid: String, avatarID: Int, skills: [GenshinRoleSkillItemModel]) {
        SQLManager.shared.upgradeGenshinCharacter(uuid: uid, avatarID: avatarID, skills: skills)
    }
}

extension SQLManagerHelper {
    func saveGenshinWeapons(weapons: [GenshinWeaponItemModel]) {
        for weapon in weapons {
            SQLManager.shared.getGenshinWeaponInfo(uWeaponID: weapon.weaponCatId ?? 0)
                .sink { item in
                    if item == nil {
                        SQLManager.shared.addGenshinWeaponInfo(model: weapon)
                    }
                }
                .store(in: &cancellables)
        }
    }
    
    func saveGenshinWeapons(weaponID: Int, computeInfo: GenshinWeaponComputeItemModel) {
        SQLManager.shared.updateGenshinWeaponInfo(uWeaponID: weaponID, model: computeInfo)
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
