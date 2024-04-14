//
//  SQLManager+GenshinRoleSkill.swift
//  MiTool
//
//  Created by Cain on 2024/4/10.
//

import Foundation
import SQLite
import Combine

private let index = Expression<Int>("index")            // 索引
private let uid = Expression<String>("uid")             // 游戏UID
private let itemID = Expression<Int>("itemID")       // 角色ID
private let skillID = Expression<Int?>("skillID")     // 技能ID
private let groupID = Expression<Int?>("groupID")     // Group ID
private let name = Expression<String?>("name")           // 技能名字
private let icon = Expression<String?>("icon")           // 技能 icon
private let maxLevel = Expression<Int>("maxLevel")   // 技能等级上限

extension SQLManager {
    func createGenshinRoleSkillTable(_ dataBase: Connection) {
        do {
            try dataBase.run(genshinImpactSkills.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid)
                table.column(itemID)
                table.column(skillID)
                table.column(groupID)
                table.column(name)
                table.column(icon)
                table.column(maxLevel)
            })
        } catch {
            #if DEBUG
            Logger.error(error)
            #endif
        }
    }

    func addGenshinRoleSkill(
        uuid: String,
        roleID: Int,
        model: GenshinRoleSkillItemModel
    ) {
        do {
            let insert = genshinImpactSkills.insert(
                uid <- uuid,
                itemID <- roleID,
                skillID <- model.skillID,
                groupID <- model.groupID,
                name <- model.name,
                icon <- model.icon,
                maxLevel <- model.maxLevel
            )
            try dataBase.run(insert)
        } catch {
            Logger.error(error)
        }
    }
    
    func upgradeGenshinRoleSkill(
        uuid: String,
        roleID: Int,
        model: GenshinRoleSkillItemModel
    ) {
        do {
            let query = genshinImpactSkills.filter(
                uid == uuid &&
                itemID == roleID
            )
            try dataBase.run(query.update(
                itemID <- roleID,
                skillID <- model.skillID,
                groupID <- model.groupID,
                name <- model.name,
                icon <- model.icon,
                maxLevel <- model.maxLevel
            ))
        } catch {
            Logger.error(error)
        }
    }
    
    func getGenshinRoleSkill(
        uuid: String,
        roleID: Int
    ) -> AnyPublisher<GenshinRoleSkillItemModel?, Never> {
        Future<GenshinRoleSkillItemModel?, Never> { [weak self] promise in
            guard let self = self else {
                return
            }
            do {
                try self.dataBase.transaction {
                    let query = self.genshinImpactSkills.filter(
                        uid == uuid &&
                        itemID == roleID
                    )
                    try self.dataBase.prepare(query).forEach { item in
                        let item = GenshinRoleSkillItemModel(
                            roleID: item[itemID],
                            skillID: item[skillID],
                            groupID: item[groupID],
                            name: item[name],
                            icon: item[icon],
                            maxLevel: item[maxLevel]
                        )
                        promise(.success(item))
                    }
                    promise(.success(nil))
                }
            } catch {
                Logger.error(error)
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getGenshinRoleAllSkill(uuid: String) -> [GenshinRoleSkillItemModel] {
        var list: [GenshinRoleSkillItemModel] = []
        do {
            let query = self.genshinImpactSkills.filter(
                uid == uuid
            )
            try dataBase.prepare(query).forEach { item in
                let item = GenshinRoleSkillItemModel(
                    roleID: item[itemID],
                    skillID: item[skillID],
                    groupID: item[groupID],
                    name: item[name],
                    icon: item[icon],
                    maxLevel: item[maxLevel]
                )
                list.append(item)
            }
            return list
        } catch {
            Logger.error(error)
            return list
        }
    }
}
