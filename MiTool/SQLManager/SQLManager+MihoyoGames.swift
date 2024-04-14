//
//  SQLManager+MihoyoGames.swift
//  MiTool
//
//  Created by Cain on 2024/4/13.
//

import Foundation
import SQLite
import Combine

private let index = Expression<Int64>("index")                          // 索引
private let uid = Expression<String>("uid")                             // 用户ID
private let gameBiz = Expression<String>("gameBiz")                             // 用户ID
private let region = Expression<String>("region")                             // 用户ID
private let gameUID = Expression<String>("gameUID")                             // 用户ID
private let nickname = Expression<String>("nickname")                             // 用户ID
private let level = Expression<Int>("level")                             // 用户ID
private let isChosen = Expression<Bool>("isChosen")                             // 用户ID
private let regionName = Expression<String>("regionName")                             // 用户ID
private let isOfficial = Expression<Bool>("isOfficial")                             // 用户ID

extension SQLManager {
    func createMihoyoGamesTable(_ dataBase: Connection) {
        do {
            try dataBase.run(mihoyoGames.create { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid)
                table.column(gameBiz)
                table.column(region)
                table.column(gameUID, unique: true)
                table.column(nickname)
                table.column(level)
                table.column(isChosen)
                table.column(regionName)
                table.column(isOfficial)
            })
        } catch {
            Logger.error(error)
        }
    }
    
    func addMihoyoGame(
        uuid: String,
        model: MihoyoGamesItemModel
    ) {
        do {
            let insert = mihoyoGames.insert(
                uid <- uuid,
                gameBiz <- model.gameBiz,
                region <- model.region,
                gameUID <- model.gameUID,
                nickname <- model.nickname,
                level <- model.level,
                isChosen <- model.isChosen,
                regionName <- model.regionName,
                isOfficial <- model.isOfficial
            )
            try dataBase.run(insert)
        } catch {
            Logger.error(error)
        }
    }

    func upgradeMihoyoGame(
        uuid: String,
        model: MihoyoGamesItemModel
    ) {
        let filter = mihoyoGames.filter(
            uid == uuid &&
            gameUID == model.gameUID
        )
        do {
            try dataBase.run(filter.update(
                gameBiz <- model.gameBiz,
                region <- model.region,
                gameUID <- model.gameUID,
                nickname <- model.nickname,
                level <- model.level,
                isChosen <- model.isChosen,
                regionName <- model.regionName,
                isOfficial <- model.isOfficial
            ))
        } catch {
            Logger.error(error)
        }
    }

    func getMihoyoGame(
        with uuid: String,
        gameUUID: String
    ) -> AnyPublisher<MihoyoGamesItemModel, Never> {
        Future { [weak self] promise in
            guard let self = self else {
                return
            }
            do {
                let query = mihoyoGames.filter(
                    uid == uuid &&
                    gameUID == gameUUID
                )
                try dataBase.prepare(query).forEach { item in
                    let model = MihoyoGamesItemModel(
                        gameBiz: item[gameBiz],
                        region: item[region],
                        gameUID: item[gameUID],
                        nickname: item[nickname],
                        level: item[level],
                        isChosen: item[isChosen],
                        regionName: item[regionName],
                        isOfficial: item[isOfficial]
                    )
                    promise(.success(model))
                }
            } catch {
                Logger.error(error)
            }
        }.eraseToAnyPublisher()
    }
    
    func getMihoyoGames() -> AnyPublisher<[MihoyoGamesItemModel], Never> {
        Future { [weak self] promise in
            guard let self = self else {
                return
            }
            var list: [MihoyoGamesItemModel] = []
            do {
                try dataBase.prepare(mihoyoGames).forEach { item in
                    let model = MihoyoGamesItemModel(
                        gameBiz: item[gameBiz],
                        region: item[region],
                        gameUID: item[gameUID],
                        nickname: item[nickname],
                        level: item[level],
                        isChosen: item[isChosen],
                        regionName: item[regionName],
                        isOfficial: item[isOfficial]
                    )
                    list.append(model)
                }
                promise(.success(list))
            } catch {
                Logger.error(error)
            }
        }.eraseToAnyPublisher()
    }}
