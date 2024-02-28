//
//  SQLManager+StarRailRole.swift
//  Barbatos
//
//  Created by Cain J H LUO_SP on 2022/10/22.
//

import Foundation
import SQLite

fileprivate let index = Expression<Int64>("index")                          // 索引
fileprivate let uid = Expression<String>("uid")                             // 用户ID
fileprivate let itemID = Expression<String?>("itemID")                      // 角色 ID
fileprivate let itemName = Expression<String?>("itemName")                  // 角色名称
fileprivate let iconURL = Expression<String?>("iconURL")                    // 角色 icon
fileprivate let damageType = Expression<String?>("damageType")              // 角色属性
fileprivate let rarity = Expression<String?>("rarity")                      // 星级
fileprivate let avatarBaseType = Expression<String?>("avatarBaseType")      // 角色命途
fileprivate let maxLevel = Expression<Int?>("maxLevel")                     // 角色最高等级
fileprivate let curLevel = Expression<Int?>("curLevel")                     // 角色当前等级
fileprivate let targetLevel = Expression<Int?>("targetLevel")               // 角色目标等级
fileprivate let verticalIconURL = Expression<String?>("verticalIconURL")    // 角色垂直 icon URL
fileprivate let isForward = Expression<Bool>("isForward")                   // 角色是否是前瞻

extension SQLManager {
    
    /// 创建 StarRailRole 表
    /// - Parameter db: Connection
    func creteStarRailRoleTable(_ db: Connection) {
        do {
            try db.run(starRailRole.create(ifNotExists: true) { t in
                t.column(index, primaryKey: .autoincrement)
                t.column(uid)
                t.column(itemID)
                t.column(itemName)
                t.column(iconURL)
                t.column(damageType)
                t.column(rarity)
                t.column(avatarBaseType)
                t.column(maxLevel)
                t.column(curLevel)
                t.column(targetLevel)
                t.column(verticalIconURL)
                t.column(isForward)
            })
        } catch {
            debugPrint(error)
        }
    }
    
    /// 添加角色详情
    /// - Parameters:
    ///   - uuid: Star Rail UID
    ///   - model: StarRailAllRoleListModel
    ///   - complete: ((Bool, Error?) -> Void)?
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
    
    /// 更新角色的基本信息
    /// - Parameters:
    ///   - uuid: Star Rail UID
    ///   - model: StarRailAllRoleListModel
    ///   - complete: complete: ((Bool, Error?) -> Void)?
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
    
    /// 获取整个角色列表
    /// - Parameter uuid: Star Rail UID
    /// - Returns: [StarRailAllRoleListModel]]
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
