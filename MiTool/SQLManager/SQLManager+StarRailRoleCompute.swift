//
//  SQLManager+StarRailRoleCompute.swift
//  MiTool
//
//  Created by Cain on 2024/2/28.
//

import Foundation
import SQLite

fileprivate let index = Expression<Int64>("index")                              // 索引
fileprivate let uid = Expression<String?>("uid")                                // UID
fileprivate let itemID = Expression<String?>("itemID")                          // 角色 ID
fileprivate let avatarConsume = Expression<String?>("avatar_consume")           // 角色等级培养耗材
fileprivate let skillConsume = Expression<String?>("skill_consume")             // 角色行迹培养耗材
fileprivate let equipmentConsume = Expression<String?>("equipment_consume")     // 角色光锥培养耗材
fileprivate let userOwnsMaterials = Expression<String?>("user_owns_materials")  // 用户已有耗材的类型
fileprivate let needGetMaterials = Expression<String?>("need_get_materials")    // 需要获取的耗材
fileprivate let canPayMaterials = Expression<String?>("can_pay_materials")      // 可以支出的耗材
fileprivate let canMergeMaterials = Expression<String?>("can_merge_materials")  // 可以合成的耗材
fileprivate let coinID = Expression<String?>("coin_id")                         // coinID

extension SQLManager {
    /// 创建 starRailRoleSkill 表
    /// - Parameter db: Connection
    func cretestarRailRoleComputeTable(_ db: Connection) {
        do {
            try db.run(starRailRoleSkill.create(ifNotExists: true) { t in
                t.column(index, primaryKey: .autoincrement)
                t.column(itemID)
                t.column(avatarConsume)
                t.column(skillConsume)
                t.column(equipmentConsume)
                t.column(userOwnsMaterials)
                t.column(needGetMaterials)
                t.column(canPayMaterials)
                t.column(canMergeMaterials)
                t.column(coinID)
            })
        } catch {
            debugPrint(error)
        }
    }
    
    /// 添加角色的培养耗材
    /// - Parameters:
    ///   - uuid: String
    ///   - model: StarRailSkillComputeData
    ///   - complete: complete: ((Bool, Error?) -> Void)?
    func addStarRailRoleComputeInfo(uuid: String,
                                    roleID: String,
                                    model: StarRailSkillComputeData,
                                    complete: ((Bool, Error?) -> Void)?) {
        do {
            let insert = starRailRoleCompute.insert(
                uid <- uuid,
                itemID <- roleID,
                avatarConsume <- model.avatarConsume?.toJSONString(),
                skillConsume <- model.skillConsume?.toJSONString(),
                equipmentConsume <- model.equipmentConsume?.toJSONString(),
                userOwnsMaterials <- model.userOwnsMaterialsString,
                needGetMaterials <- model.needGetMaterials?.toJSONString(),
                canPayMaterials <- model.canPayMaterials?.toJSONString(),
                canMergeMaterials <- model.canMergeMaterials?.toJSONString(),
                coinID <- model.coinID
            )
            try db.run(insert)
            complete?(true, nil)
        } catch {
            debugPrint(error)
            complete?(false, error)
        }
    }
    
    /// 更新角色的培养耗材信息
    /// - Parameters:
    ///   - uuid: Star Rail UID
    ///   - model: StarRailAllRoleListModel
    ///   - complete: complete: ((Bool, Error?) -> Void)?
    func upgradeStarRailRoleComputeInfo(uuid: String,
                                        roleID: String,
                                        model: StarRailSkillComputeData,
                                        complete: ((Bool, Error?) -> Void)?) {
        do {
            try db.transaction {
                let starRailRole = starRailRoleSkill.filter(
                    uid == uuid &&
                    itemID == roleID
                )
                try db.run(starRailRoleSkill.update(
                    uid <- uuid,
                    avatarConsume <- model.avatarConsume?.toJSONString(),
                    skillConsume <- model.skillConsume?.toJSONString(),
                    equipmentConsume <- model.equipmentConsume?.toJSONString(),
                    userOwnsMaterials <- model.userOwnsMaterialsString,
                    needGetMaterials <- model.needGetMaterials?.toJSONString(),
                    canPayMaterials <- model.canPayMaterials?.toJSONString(),
                    canMergeMaterials <- model.canMergeMaterials?.toJSONString(),
                    coinID <- model.coinID
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }
    
    /// 获取所有角色培养耗材列表
    /// - Parameter uuid: Star Rail UID
    /// - Returns: [StarRailAllRoleListModel]]
    func getAllStarRailRoleComputeList(uuid: String) -> [StarRailSkillComputeData] {
        var list: [StarRailSkillComputeData] = []
        
        do {
            try db.transaction {
                try db.prepare(starRailRoleSkill).forEach { item in
                    let model = StarRailSkillComputeData(
                        avatarConsume: item[avatarConsume],
                        skillConsume: item[skillConsume],
                        equipmentConsume: item[equipmentConsume],
                        userOwnsMaterials: item[userOwnsMaterials],
                        needGetMaterials: item[needGetMaterials],
                        canPayMaterials: item[canPayMaterials],
                        canMergeMaterials: item[canMergeMaterials],
                        coinID: item[coinID]
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
