//
//  SQLManager+GameRecord.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/3.
//

import Foundation
import SQLite

private let index = Expression<Int64>("index")          // 索引
private let uid = Expression<String?>("uid")            // 米哈游UID
private let gameCard = Expression<String?>("gameCard")  // 游戏卡片，原神id：1，星穹铁道id：6
private let starRail = Expression<String?>("starRail")  // 游戏卡片，星穹铁道id：6
private let genshin = Expression<String?>("genshin")    // 游戏卡片，原神id：1

extension SQLManager {
    func createMihoyoGameCardsTable(_ dataBase: Connection) {
        do {
            try dataBase.run(mihoyoGameCards.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid, unique: true)
                table.column(gameCard)
                table.column(starRail)
                table.column(genshin)
            })
        } catch {
            Logger.error(error)
        }
    }
    
    func addMihoyoGameCards(
        uuid: String,
        model: [MihoyoGameCardsList],
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let insert = mihoyoGameCards.insert(
                uid <- uuid,
                gameCard <- model.toJSONString()
            )
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            Logger.error(error)
            complete?(false, error)
        }
    }

    func addStarRailCards(
        uuid: String,
        model: MihoyoGameCardsList,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let insert = mihoyoGameCards.insert(
                uid <- uuid,
                starRail <- model.toJSONString()
            )
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            Logger.error(error)
            complete?(false, error)
        }
    }

    func addGenshinCards(
        uuid: String,
        model: MihoyoGameCardsList,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let insert = mihoyoGameCards.insert(
                uid <- uuid,
                genshin <- model.toJSONString()
            )
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            Logger.error(error)
            complete?(false, error)
        }
    }

    func upgradeMihoyoGameCards(
        uuid: String,
        model: [MihoyoGameCardsList],
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let starRailRoleSkill = mihoyoGameCards.filter(
                    uid == uuid)
                try dataBase.run(starRailRoleSkill.update(
                    uid <- uuid,
                    gameCard <- model.toJSONString()
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }

    func upgradeStarRailGameCards(
        uuid: String,
        model: MihoyoGameCardsList,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let starRailRoleSkill = mihoyoGameCards.filter(
                    uid == uuid)
                try dataBase.run(starRailRoleSkill.update(
                    uid <- uuid,
                    starRail <- model.toJSONString()
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }

    func upgradeGenshinGameCards(
        uuid: String,
        model: MihoyoGameCardsList,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let starRailRoleSkill = mihoyoGameCards.filter(
                    uid == uuid)
                try dataBase.run(starRailRoleSkill.update(
                    uid <- uuid,
                    genshin <- model.toJSONString()
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }

    func getAllMihoyoGameCards(uuid: String) -> [MihoyoGameCardsList] {
        var list: [MihoyoGameCardsList] = []
        do {
            try dataBase.transaction {
                try dataBase.prepare(mihoyoGameCards).forEach { item in
                    if let gameCard = item[gameCard],
                       let models = [MihoyoGameCardsList](JSONString: gameCard) {
                        list = models
                    }
                }
            }
            return list
        } catch {
            Logger.error(error)
            return list
        }
    }
    
    func getStarRailGameCard(
        uuid: String,
        completion: (MihoyoGameCardsList) -> Void
    ) {
        do {
            try dataBase.transaction {
                let query = mihoyoGameCards.filter(
                    uid == uuid
                )
                try dataBase.prepare(query).forEach { item in
                    if let gameCard = item[starRail],
                       let starRail = MihoyoGameCardsList(JSONString: gameCard) {
                        completion(starRail)
                    }
                }
            }
        } catch {
            Logger.error(error)
        }
    }
}
