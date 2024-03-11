//
//  SQLManager+StarRailRoleCompute.swift
//  MiTool
//
//  Created by Cain on 2024/2/28.
//

import Foundation
import SQLite

private let index = Expression<Int64>("index")                              // 索引
private let uid = Expression<String?>("uid")                                // UID
private let itemID = Expression<String?>("itemID")                          // 角色 ID
private let avatarConsume = Expression<String?>("avatarConsume")           // 角色等级培养耗材
private let skillConsume = Expression<String?>("skillConsume")             // 角色行迹培养耗材
private let equipmentConsume = Expression<String?>("equipmentConsume")     // 角色光锥培养耗材
private let userOwnsMaterials = Expression<String?>("userOwnsMaterials")  // 用户已有耗材的类型
private let needGetMaterials = Expression<String?>("needGetMaterials")    // 需要获取的耗材
private let canPayMaterials = Expression<String?>("canPayMaterials")      // 可以支出的耗材
private let canMergeMaterials = Expression<String?>("canMergeMaterials")  // 可以合成的耗材
private let coinID = Expression<String?>("coinID")                         // coinID

extension SQLManager {
    func cretestarRailRoleComputeTable(_ dataBase: Connection) {
        do {
            try dataBase.run(starRailRoleCompute.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid)
                table.column(itemID)
                table.column(avatarConsume)
                table.column(skillConsume)
                table.column(equipmentConsume)
                table.column(userOwnsMaterials)
                table.column(needGetMaterials)
                table.column(canPayMaterials)
                table.column(canMergeMaterials)
                table.column(coinID)
            })
        } catch {
            Logger.error(message: error)
        }
    }

    func addStarRailRoleComputeInfo(
        uuid: String,
        roleID: String,
        model: StarRailSkillComputeData,
        complete: ((Bool, Error?) -> Void)?
    ) {
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
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            Logger.error(message: error)
            complete?(false, error)
        }
    }

    func upgradeStarRailRoleComputeInfo(
        uuid: String,
        roleID: String,
        model: StarRailSkillComputeData,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let starRailRole = starRailRoleCompute.filter(
                    uid == uuid &&
                    itemID == roleID
                )
                try dataBase.run(starRailRole.update(
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
    
    func getStarRailRoleCompute(
        _ uuid: String,
        roleID: String,
        complete: ((Bool, StarRailSkillComputeData?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let query = starRailRoleCompute.filter(
                    uid == uuid &&
                    itemID == roleID
                )
                try dataBase.prepare(query).forEach { item in
                    complete?(true, StarRailSkillComputeData(
                        avatarConsume: item[avatarConsume],
                        skillConsume: item[skillConsume],
                        equipmentConsume: item[equipmentConsume],
                        userOwnsMaterials: item[userOwnsMaterials],
                        needGetMaterials: item[needGetMaterials],
                        canPayMaterials: item[canPayMaterials],
                        canMergeMaterials: item[canMergeMaterials],
                        coinID: item[coinID]
                    ))
                }
            }
            complete?(false, nil)
        } catch {
            Logger.error(message: error)
            complete?(false, nil)
        }
    }

    func getAllStarRailRoleComputeList(uuid: String) -> [StarRailSkillComputeData] {
        var list: [StarRailSkillComputeData] = []
        
        do {
            try dataBase.transaction {
                try dataBase.prepare(starRailRoleCompute).forEach { item in
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
            Logger.error(message: error)
            return list
        }
    }
}
