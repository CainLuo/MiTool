//
//  SQLManager+StarRailRole.swift
//  Barbatos
//
//  Created by Cain J H LUO_SP on 2022/10/22.
//

import Foundation
import SQLite

private let index = Expression<Int64>("index")                          // 索引
private let uid = Expression<String>("uid")                             // 用户ID
private let itemID = Expression<String?>("itemID")                      // 角色 ID
private let itemName = Expression<String?>("itemName")                  // 角色名称
private let iconURL = Expression<String?>("iconURL")                    // 角色 icon
private let damageType = Expression<String?>("damageType")              // 角色属性
private let rarity = Expression<String?>("rarity")                      // 星级
private let avatarBaseType = Expression<String?>("avatarBaseType")      // 角色命途
private let maxLevel = Expression<Int?>("maxLevel")                     // 角色最高等级
private let curLevel = Expression<Int?>("curLevel")                     // 角色当前等级
private let targetLevel = Expression<Int?>("targetLevel")               // 角色目标等级
private let verticalIconURL = Expression<String?>("verticalIconURL")    // 角色垂直 icon URL
private let isForward = Expression<Bool>("isForward")                   // 角色是否是前瞻

extension SQLManager {
    func creteStarRailRoleTable(_ db: Connection) {
        do {
            try db.run(starRailRole.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid)
                table.column(itemID)
                table.column(itemName)
                table.column(iconURL)
                table.column(damageType)
                table.column(rarity)
                table.column(avatarBaseType)
                table.column(maxLevel)
                table.column(curLevel)
                table.column(targetLevel)
                table.column(verticalIconURL)
                table.column(isForward)
            })
        } catch {
            debugPrint(error)
        }
    }

    func addStarRailRoleInfo(uuid: String,
                             model: StarRailAllRoleListModel,
                             complete: ((Bool, Error?) -> Void)?) {
        do {
            let insert = starRailRole.insert(
                uid <- uuid,
                itemID <- model.itemID,
                itemName <- model.itemName,
                iconURL <- model.iconURL,
                damageType <- model.damageType?.rawValue,
                rarity <- model.rarity?.rawValue,
                avatarBaseType <- model.avatarBaseType?.rawValue,
                maxLevel <- model.maxLevel,
                curLevel <- model.curLevel,
                targetLevel <- model.targetLevel,
                verticalIconURL <- model.verticalIconURL,
                isForward <- model.isForward ?? false
            )
            try db.run(insert)
            complete?(true, nil)
        } catch {
            debugPrint(error)
            complete?(false, error)
        }
    }

    func upgradeStarRailRoleInfo(uuid: String,
                                 model: StarRailAllRoleListModel,
                                 complete: ((Bool, Error?) -> Void)?) {
        do {
            try db.transaction {
                let starRailRole = starRailRole.filter(
                    uid == uuid &&
                    itemID == model.itemID ?? ""
                )
                try db.run(starRailRole.update(
                    itemName <- model.itemName,
                    iconURL <- model.iconURL,
                    damageType <- model.damageType?.rawValue,
                    rarity <- model.rarity?.rawValue,
                    avatarBaseType <- model.avatarBaseType?.rawValue,
                    maxLevel <- model.maxLevel,
                    curLevel <- model.curLevel,
                    targetLevel <- model.targetLevel,
                    verticalIconURL <- model.verticalIconURL,
                    isForward <- model.isForward ?? false
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }

    func getAllStarRailRoleList(uuid: String) -> [StarRailAllRoleListModel] {
        var list: [StarRailAllRoleListModel] = []
        do {
            try db.transaction {
                try db.prepare(starRailRole).forEach { item in
                    let model = StarRailAllRoleListModel(
                        itemID: item[itemID],
                        itemName: item[itemName],
                        iconURL: item[iconURL],
                        damageType: Damage(rawValue: item[damageType] ?? ""),
                        rarity: RarityType(rawValue: item[rarity] ?? ""),
                        avatarBaseType: Destiny(rawValue: item[avatarBaseType] ?? ""),
                        maxLevel: item[maxLevel],
                        curLevel: item[curLevel],
                        targetLevel: item[targetLevel],
                        verticalIconURL: item[verticalIconURL],
                        isForward: item[isForward]
                    )
                    list.append(model)
                }
            }
            return list
        } catch {
            print(error)
            return list
        }
    }
}
