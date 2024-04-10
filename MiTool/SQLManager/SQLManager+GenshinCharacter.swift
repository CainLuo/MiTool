//
//  SQLManager+GenshinCharacter.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import Foundation
import SQLite
import Combine

private let index = Expression<Int>("index")          // 索引
private let uid = Expression<String>("id")          // 米游社ID
private let characterID = Expression<Int?>("characterID")          // 角色ID
private let image = Expression<String?>("image")          // 角色立绘
private let icon = Expression<String?>("icon")          // 角色icon
private let name = Expression<String?>("name")          // 角色名字
private let element = Expression<String?>("element")          // 角色属性
private let fetter = Expression<Int?>("fetter")          // 好友度
private let level = Expression<Int?>("level")          // 等级
private let rarity = Expression<Int?>("rarity")          // 星级
private let weapon = Expression<String?>("weapon")          // 武器
private let reliquaries = Expression<String?>("reliquaries")          // 圣遗物
private let constellations = Expression<String?>("constellations")          // 命座信息
private let activedConstellationNum = Expression<Int?>("actived_constellation_num")          // 已激活命座
private let costumes = Expression<String?>("costumes")          // 服装
private let skillList = Expression<String?>("skillList")          // 技能

extension SQLManager {
    func createGenshiCharacterTable(_ dataBase: Connection) {
        do {
            try dataBase.run(genshinImpactCharacter.create { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid)
                table.column(characterID)
                table.column(image)
                table.column(icon)
                table.column(name)
                table.column(element)
                table.column(fetter)
                table.column(level)
                table.column(rarity)
                table.column(weapon)
                table.column(reliquaries)
                table.column(constellations)
                table.column(activedConstellationNum)
                table.column(costumes)
                table.column(skillList)
            })
        } catch {
            Logger.error(error)
        }
    }
    
    func addGenshinCharacter(
        uuid: String,
        model: GenshinCharacterAvatar
    ) {
        do {
            try dataBase.transaction {
                let insert = genshinImpactCharacter.insert(
                    uid <- uuid,
                    characterID <- model.avatarID,
                    image <- model.image,
                    icon <- model.icon,
                    name <- model.name,
                    element <- model.element,
                    fetter <- model.fetter,
                    level <- model.level,
                    rarity <- model.rarity.rawValue,
                    weapon <- model.weapon?.toJSONString(),
                    reliquaries <- model.reliquaries?.toJSONString(),
                    constellations <- model.constellations?.toJSONString(),
                    activedConstellationNum <- model.activedConstellationNum,
                    costumes <- model.costumes?.toJSONString(),
                    skillList <- model.skillList?.toJSONString()
                )
                try dataBase.run(insert)
            }
        } catch {
            Logger.error(error)
        }
    }
    
    func getGenshinCharacter(uuid: String) -> [GenshinCharacterAvatar] {
        var list: [GenshinCharacterAvatar] = []
        do {
            try dataBase.transaction {
                let query = genshinImpactCharacter.filter(
                    uid == uuid
                )
                try dataBase.prepare(query).forEach { item in
                    let avatar = GenshinCharacterAvatar(
                        avatarID: item[characterID],
                        image: item[image],
                        icon: item[icon],
                        name: item[name],
                        element: item[element],
                        fetter: item[fetter],
                        level: item[level],
                        rarity: item[rarity],
                        weapon: item[weapon],
                        reliquaries: item[reliquaries],
                        constellations: item[constellations],
                        activedConstellationNum: item[activedConstellationNum],
                        costumes: item[costumes],
                        skillList: item[skillList]
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
    
    func getGenshinCharacter(
        uuid: String,
        avatarID: Int
    ) -> AnyPublisher<GenshinCharacterAvatar?, Never> {
        return Future<GenshinCharacterAvatar?, Never> { [weak self] promise in
            guard let self = self else {
                return
            }
            do {
                try self.dataBase.transaction {
                    let query = self.genshinImpactCharacter.filter(
                        uid == uuid &&
                        characterID == avatarID
                    )
                    try self.dataBase.prepare(query).forEach { item in
                        let avatar = GenshinCharacterAvatar(
                            avatarID: item[characterID],
                            image: item[image],
                            icon: item[icon],
                            name: item[name],
                            element: item[element],
                            fetter: item[fetter],
                            level: item[level],
                            rarity: item[rarity],
                            weapon: item[weapon],
                            reliquaries: item[reliquaries],
                            constellations: item[constellations],
                            activedConstellationNum: item[activedConstellationNum],
                            costumes: item[costumes],
                            skillList: item[skillList]
                        )
                        promise(.success(avatar))
                    }
                }
            } catch {
                Logger.error(error)
            }
        }.eraseToAnyPublisher()
    }

    func upgradeGenshinCharacter(
        uuid: String,
        model: GenshinCharacterAvatar
    ) {
        do {
            try dataBase.transaction {
                let query = genshinImpactCharacter.filter(
                    uid == uuid &&
                    characterID == model.avatarID ?? 0
                )
                try dataBase.run(query.update(
                    characterID <- model.avatarID,
                    image <- model.image,
                    icon <- model.icon,
                    name <- model.name,
                    element <- model.element,
                    fetter <- model.fetter,
                    level <- model.level,
                    rarity <- model.rarity.rawValue,
                    weapon <- model.weapon?.toJSONString(),
                    reliquaries <- model.reliquaries?.toJSONString(),
                    constellations <- model.constellations?.toJSONString(),
                    activedConstellationNum <- model.activedConstellationNum,
                    costumes <- model.costumes?.toJSONString()
                ))
            }
        } catch {
            Logger.error(error)
        }
    }
    
    func upgradeGenshinCharacter(
        uuid: String,
        avatarID: Int,
        skills: [GenshinRoleSkillItemModel]
    ) {
        do {
            try dataBase.transaction {
                let query = genshinImpactCharacter.filter(
                    uid == uuid &&
                    characterID == avatarID
                )
                try dataBase.run(query.update(
                    skillList <- skills.toJSONString()
                ))
            }
        } catch {
            Logger.error(error)
        }
    }
}
