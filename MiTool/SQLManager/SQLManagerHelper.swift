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

    func saveMihoyoGames(
        _ uid: String,
        gameCards: [MihoyoGamesItemModel]
    ) {
        SQLManager.shared.getMihoyoGames()
            .sink { games in
                gameCards.forEach { gameItem in
                    let hasGame = games.contains { $0.gameUID == gameItem.gameUID }
                    if hasGame {
                        SQLManager.shared.upgradeMihoyoGame(uuid: uid, model: gameItem)
                    } else {
                        SQLManager.shared.addMihoyoGame(uuid: uid, model: gameItem)
                    }
                }
            }
            .store(in: &cancellables)
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
    
    func saveGenshinCharacter(uid: String, list: [GenshinCharacterAvatar]) {
        list.forEach { avatar in
            guard let avatarID = avatar.avatarID else {
                return
            }
            
            SQLManager.shared.getGenshinCharacter(uuid: uid, avatarID: avatarID)
                .sink { item in
                    guard item != nil else {
                        SQLManager.shared.addGenshinCharacter(uuid: uid, model: avatar)
                        return
                    }
                    SQLManager.shared.upgradeGenshinCharacter(uuid: uid, model: avatar)
                }
                .store(in: &cancellables)
        }
    }
    
    func saveGenshinSkills(uid: String, roleID: Int, skills: [GenshinRoleSkillItemModel]) {
        SQLManager.shared.getGenshinCharacter(uuid: uid, avatarID: roleID)
            .sink { item in
                guard item != nil else {
                    return
                }
                SQLManager.shared.upgradeGenshinCharacter(uuid: uid, avatarID: roleID, skills: skills)
            }
            .store(in: &cancellables)
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
    static func saveStarRailRoleDetail(uid: String, list: [StarRailAllRoleListModel]) {
        for role in list {
            SQLManager.shared.getStarRailRoleInfo(
                uid, roleID: role.itemID ?? ""
            ) { _, item in
                if item != nil {
                    SQLManager.shared.upgradeStarRailRoleInfo(uuid: uid, model: role)
                } else {
                    SQLManager.shared.addStarRailRoleInfo(uuid: uid, model: role)
                }
            }
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
    func saveStarRailRole(
        uid: String,
        roleID: String,
        info: StarRailSkillComputeData
    ) {
        SQLManager.shared.getStarRailRoleCompute(
            uid, roleID: roleID
        ) { _, item in
        }
        
        SQLManager.shared.getStarRailRoleCompute(uid, roleID: roleID)
            .sink { [weak self] item in
                if item != nil {
                    self?.upgradeStarRailRoleCompute(uid: uid, roleID: roleID, info: info)
                } else {
                    self?.addStarRailRoleCompute(uid: uid, roleID: roleID, info: info)
                }
            }
            .store(in: &cancellables)
    }
    
    func addStarRailRoleCompute(
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
    
    func upgradeStarRailRoleCompute(
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
