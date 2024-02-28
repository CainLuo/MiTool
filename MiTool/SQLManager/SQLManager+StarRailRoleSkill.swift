//
//  SQLManager+StarRailRoleSkill.swift
//  MiTool
//
//  Created by Cain on 2024/2/28.
//

import Foundation
import SQLite

fileprivate let index = Expression<Int64>("index")                  // 索引
fileprivate let uid = Expression<String?>("uid")                    // UID
fileprivate let avatar = Expression<String?>("avatar")              // 角色信息
fileprivate let itemID = Expression<String?>("itemID")              // 角色 ID
fileprivate let skills = Expression<String?>("skills")              // 角色主要技能信息
fileprivate let skillsOther = Expression<String?>("skillsOther")    // 角色其他天赋信息
fileprivate let equipment = Expression<String?>("equipment")        // 光锥信息
fileprivate let isLogin = Expression<Bool?>("isLogin")              // 是否登录

extension SQLManager {
    /// 创建 StarRailRole 表
    /// - Parameter db: Connection
    func creteStarRailRoleSkillTable(_ db: Connection) {
        do {
            try db.run(starRailRoleSkill.create(ifNotExists: true) { t in
                t.column(index, primaryKey: .autoincrement)
                t.column(uid)
                t.column(itemID)
                t.column(avatar)
                t.column(skills)
                t.column(skillsOther)
                t.column(equipment)
                t.column(isLogin)
            })
        } catch {
            debugPrint(error)
        }
    }

    /// 添加角色当前等级, 行迹, 光锥的信息
    /// - Parameters:
    ///   - uuid: Star Rail UID
    ///   - model: StarRailAllRoleListModel
    ///   - complete: ((Bool, Error?) -> Void)?
    func addStarRailRoleSkillInfo(uuid: String,
                                  model: StarRailRoleInfoData,
                                  complete: ((Bool, Error?) -> Void)?) {
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
            try db.run(insert)
            complete?(true, nil)
        } catch {
            debugPrint(error)
            complete?(false, error)
        }
    }
    
    /// 更新角色当前等级, 行迹, 光锥基本信息
    /// - Parameters:
    ///   - uuid: Star Rail UID
    ///   - model: StarRailAllRoleListModel
    ///   - complete: complete: ((Bool, Error?) -> Void)?
    func upgradeStarRailRoleSkillInfo(uuid: String,
                                      model: StarRailRoleInfoData,
                                      complete: ((Bool, Error?) -> Void)?) {
        do {
            try db.transaction {
                let starRailRoleSkill = starRailRoleSkill.filter(
                    uid == uuid &&
                    itemID == model.avatar?.itemID ?? ""
                )
                try db.run(starRailRoleSkill.update(
                    uid <- uuid,
                    itemID <- model.avatar?.itemID,
                    avatar <- model.avatar?.toJSONString(),
                    skills <- model.skills.toJSONString(),
                    skillsOther <- model.skillsOther.toJSONString(),
                    equipment <- model.equipment?.toJSONString(),
                    isLogin <- model.isLogin
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }
    
    func getAllStarRailRoleSkillList(uuid: String) -> [StarRailRoleInfoData] {
        var list: [StarRailRoleInfoData] = []
        do {
            try db.transaction {
                try db.prepare(starRailRoleSkill).forEach { item in
                    let model = StarRailRoleInfoData(
                        avatar: item[itemID],
                        skills: item[skills],
                        skillsOther: item[skillsOther],
                        equipment: item[equipment],
                        isLogin: item[isLogin] ?? false
                    )
                    list.append(model)
                }
            }
            return list
        } catch {
            debugPrint(error)
            return list
        }
    }
}
