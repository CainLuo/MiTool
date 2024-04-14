//
//  SQLManager+StarRailRoleSkill.swift
//  MiTool
//
//  Created by Cain on 2024/2/28.
//

import Foundation
import SQLite

private let index = Expression<Int64>("index")                  // 索引
private let uid = Expression<String?>("uid")                    // UID
private let avatar = Expression<String?>("avatar")              // 角色信息
private let itemID = Expression<String?>("itemID")              // 角色 ID
private let skills = Expression<String?>("skills")              // 角色主要技能信息
private let skillsOther = Expression<String?>("skillsOther")    // 角色其他天赋信息
private let equipment = Expression<String?>("equipment")        // 光锥信息
private let isLogin = Expression<Bool?>("isLogin")              // 是否登录

extension SQLManager {
    func creteStarRailRoleSkillTable(_ dataBase: Connection) {
        do {
            try dataBase.run(starRailRoleSkill.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid)
                table.column(itemID, unique: true)
                table.column(avatar)
                table.column(skills)
                table.column(skillsOther)
                table.column(equipment)
                table.column(isLogin)
            })
        } catch {
            Logger.error(error)
        }
    }

    func addStarRailRoleSkillInfo(
        uuid: String,
        model: StarRailRoleInfoData,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let insert = starRailRoleSkill.insert(
                uid <- uuid,
                itemID <- model.avatar?.itemID,
                avatar <- model.avatar?.toJSONString(),
                skills <- model.skills.toJSONString(),
                skillsOther <- model.skillsOther.toJSONString(),
                equipment <- model.equipment?.toJSONString(),
                isLogin <- model.isLogin
            )
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            Logger.error(error)
            complete?(false, error)
        }
    }

    func upgradeStarRailRoleSkillInfo(
        uuid: String,
        model: StarRailRoleInfoData,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let starRailRoleSkill = starRailRoleSkill.filter(
                uid == uuid &&
                itemID == model.avatar?.itemID ?? ""
            )
            try dataBase.run(starRailRoleSkill.update(
                uid <- uuid,
                itemID <- model.avatar?.itemID,
                avatar <- model.avatar?.toJSONString(),
                skills <- model.skills.toJSONString(),
                skillsOther <- model.skillsOther.toJSONString(),
                equipment <- model.equipment?.toJSONString(),
                isLogin <- model.isLogin
            ))
            complete?(true, nil)
        } catch {
            complete?(false, error)
        }
    }
    
    func getStarRailRoleSkills(
        _ uuid: String,
        roleID: String,
        complete: ((Bool, StarRailRoleInfoData?) -> Void)?
    ) {
        do {
            let query = starRailRoleSkill.filter(
                uid == uuid &&
                itemID == roleID
            )
            try dataBase.prepare(query).forEach { item in
                complete?(true, StarRailRoleInfoData(
                    avatar: item[avatar],
                    skills: item[skills],
                    skillsOther: item[skillsOther],
                    equipment: item[equipment],
                    isLogin: item[isLogin] ?? false
                ))
            }
            complete?(false, nil)
        } catch {
            Logger.error(error)
            complete?(false, nil)
        }
    }

    func getAllStarRailRoleSkillList(uuid: String) -> [StarRailRoleInfoData] {
        var list: [StarRailRoleInfoData] = []
        do {
            try dataBase.prepare(starRailRoleSkill).forEach { item in
                let model = StarRailRoleInfoData(
                    avatar: item[avatar],
                    skills: item[skills],
                    skillsOther: item[skillsOther],
                    equipment: item[equipment],
                    isLogin: item[isLogin] ?? false
                )
                list.append(model)
            }
            return list
        } catch {
            Logger.error(error)
            return list
        }
    }
}
