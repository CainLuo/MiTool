//
//  SQLManager+GenshinWeapon.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/5.
//

import Foundation
import SQLite
import Combine

private let index = Expression<Int>("index")                    // 索引
private let weaponID = Expression<Int?>("weaponID")             // 武器ID
private let name = Expression<String?>("name")                  // 武器名称
private let icon = Expression<String?>("icon")                  // 武器icon
private let weaponCatId = Expression<Int?>("weaponCatId")       // 武器编号ID
private let weaponLevel = Expression<Int?>("weaponLevel")       // 武器星级
private let maxLevel = Expression<Int?>("maxLevel")             // 目标等级
private let computeInfo = Expression<String?>("computeInfo")    // 养成信息

extension SQLManager {
    func createGenshinWeaponTable(_ dataBase: Connection) {
        do {
            try dataBase.run(genshinImpactWeapon.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(weaponID, unique: true)
                table.column(name)
                table.column(icon)
                table.column(weaponCatId)
                table.column(weaponLevel)
                table.column(maxLevel)
                table.column(computeInfo)
            })
        } catch {
            Logger.error(error)
        }
    }
    
    func addGenshinWeaponInfo(model: GenshinWeaponItemModel) {
        do {
            try dataBase.transaction {
                let insert = genshinImpactWeapon.insert(
                    weaponID <- model.weaponID,
                    name <- model.name,
                    icon <- model.icon,
                    weaponCatId <- model.weaponCatId,
                    weaponLevel <- model.weaponLevel.rawValue,
                    maxLevel <- model.maxLevel
                )
                try dataBase.run(insert)
            }
        } catch {
            Logger.error(error)
        }
    }
    
    func updateGenshinWeaponInfo(
        uWeaponID: Int,
        model: GenshinWeaponComputeItemModel
    ) {
        do {
            try dataBase.transaction {
                let query = genshinImpactWeapon.filter(
                    weaponID == uWeaponID
                )
                try dataBase.run(query.update(
                    computeInfo <- model.toJSONString()
                ))
            }
        } catch {
            Logger.error(error)
        }
    }
    
    func getGenshinWeaponInfo(uWeaponID: Int) -> AnyPublisher<GenshinWeaponItemModel?, Never> {
        return Future { [weak self] promise in
            guard let self else {
                return
            }
            do {
                try self.dataBase.transaction {
                    let query = self.genshinImpactWeapon.filter(weaponID == uWeaponID)
                    try self.dataBase.prepare(query).forEach { item in
                        let avatar = GenshinWeaponItemModel(
                            id: item[weaponID],
                            name: item[name],
                            icon: item[icon],
                            weaponCatId: item[weaponCatId],
                            weaponLevel: item[weaponLevel],
                            maxLevel: item[maxLevel],
                            computeInfo: item[computeInfo]
                        )
                        promise(.success(avatar))
                    }
                }
            } catch {
                Logger.error(error)
            }
        }.eraseToAnyPublisher()
    }

    func getGenshinWeapons() -> [GenshinWeaponItemModel] {
        var list: [GenshinWeaponItemModel] = []
        do {
            try dataBase.transaction {
                try dataBase.prepare(genshinImpactWeapon).forEach { item in
                    let avatar = GenshinWeaponItemModel(
                        id: item[weaponID],
                        name: item[name],
                        icon: item[icon],
                        weaponCatId: item[weaponCatId],
                        weaponLevel: item[weaponLevel],
                        maxLevel: item[maxLevel],
                        computeInfo: item[computeInfo]
                    )
                    list.append(avatar)
                }
            }
            return list
        } catch {
            Logger.error(error)
            return list
        }
    }
}
