//
//  SQLManager+StarRailDailyNode.swift
//  MiTool
//
//  Created by Cain on 2024/2/29.
//

import Foundation
import SQLite

private let index = Expression<Int64>("index")                                 // 索引
private let uid = Expression<String>("uid")                                    // 星穹铁道 UID
private let currentStamina = Expression<Int>("currentStamina")                 // 当前体力
private let maxStamina = Expression<Int>("maxStamina")                         // 最大体力
private let staminaRecoverTime = Expression<Int>("staminaRecoverTime")         // 恢复体力时间
private let acceptedEpeditionNum = Expression<Int>("acceptedEpeditionNum")     // 当前探险数量
private let totalExpeditionNum = Expression<Int>("totalExpeditionNum")         // 总的最大可探险数量
private let expeditions = Expression<String?>("expeditions")                   // 探险详情
private let currentTrainScore = Expression<Int>("currentTrainScore")           // 当前当日活跃度
private let maxTrainScore = Expression<Int>("maxTrainScore")                   // 总的当日活跃度
private let currentRogueScore = Expression<Int>("currentRogueScore")           // 本周积分
private let maxRogueScore = Expression<Int>("maxRogueScore")                   // 总的最大本周积分
private let weeklyCocoonCnt = Expression<Int>("weeklyCocoonCnt")               // 当前可用历战余响次数
private let weeklyCocoonLimit = Expression<Int>("weeklyCocoonLimit")           // 最大可用历战余响次数
private let currentReserveStamina = Expression<Int>("currentReserveStamina")   // 当前体力储备
private let isReserveStaminaFull = Expression<Bool>("isReserveStaminaFull")    // 是否有体力存储

extension SQLManager {
    func createStarRailDailyNodeTable(_ dataBase: Connection) {
        do {
            try dataBase.run(starRailDailyNode.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid)
                table.column(currentStamina)
                table.column(maxStamina)
                table.column(staminaRecoverTime)
                table.column(acceptedEpeditionNum)
                table.column(totalExpeditionNum)
                table.column(expeditions)
                table.column(currentTrainScore)
                table.column(maxTrainScore)
                table.column(currentRogueScore)
                table.column(maxRogueScore)
                table.column(weeklyCocoonCnt)
                table.column(weeklyCocoonLimit)
                table.column(currentReserveStamina)
                table.column(isReserveStaminaFull)
            })
        } catch {
            Logger.error(error)
        }
    }

    func addStarRailDailyNode(
        _ uuid: String,
        model: StarRailWidgetDataModel,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let insert = starRailDailyNode.insert(
                uid <- uuid,
                currentStamina <- model.currentStamina,
                maxStamina <- model.maxStamina,
                staminaRecoverTime <- model.staminaRecoverTime,
                acceptedEpeditionNum <- model.acceptedEpeditionNum,
                totalExpeditionNum <- model.totalExpeditionNum,
                expeditions <- model.expeditions?.toJSONString(),
                currentTrainScore <- model.currentTrainScore,
                maxRogueScore <- model.maxRogueScore,
                weeklyCocoonCnt <- model.weeklyCocoonCnt,
                weeklyCocoonLimit <- model.weeklyCocoonLimit,
                currentReserveStamina <- model.currentReserveStamina,
                isReserveStaminaFull <- model.isReserveStaminaFull
            )
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            complete?(false, error)
        }
    }

    func upgradeStarRailDailyNode(
        _ uuid: String,
        model: StarRailWidgetDataModel,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let mihoyoUser = starRailDailyNode.filter(uid == uuid)
                try dataBase.run(mihoyoUser.update(
                    uid <- uuid,
                    currentStamina <- model.currentStamina,
                    maxStamina <- model.maxStamina,
                    staminaRecoverTime <- model.staminaRecoverTime,
                    acceptedEpeditionNum <- model.acceptedEpeditionNum,
                    totalExpeditionNum <- model.totalExpeditionNum,
                    expeditions <- model.expeditions?.toJSONString(),
                    currentTrainScore <- model.currentTrainScore,
                    maxRogueScore <- model.maxRogueScore,
                    weeklyCocoonCnt <- model.weeklyCocoonCnt,
                    weeklyCocoonLimit <- model.weeklyCocoonLimit,
                    currentReserveStamina <- model.currentReserveStamina,
                    isReserveStaminaFull <- model.isReserveStaminaFull
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }

    func getStarRailRoleDailyNode(
        _ uuid: String,
        complete: ((Bool, StarRailWidgetDataModel?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let query = starRailDailyNode.filter(
                    uid == uuid
                )
                try dataBase.prepare(query).forEach { item in
                    complete?(true, StarRailWidgetDataModel(
                        currentStamina: item[currentStamina],
                        maxStamina: item[maxStamina],
                        staminaRecoverTime: item[staminaRecoverTime],
                        acceptedEpeditionNum: item[acceptedEpeditionNum],
                        totalExpeditionNum: item[totalExpeditionNum],
                        expeditions: item[expeditions],
                        currentTrainScore: item[currentTrainScore],
                        maxTrainScore: item[maxTrainScore],
                        currentRogueScore: item[currentRogueScore],
                        maxRogueScore: item[maxRogueScore],
                        weeklyCocoonCnt: item[weeklyCocoonCnt],
                        weeklyCocoonLimit: item[weeklyCocoonLimit],
                        currentReserveStamina: item[currentReserveStamina],
                        isReserveStaminaFull: item[isReserveStaminaFull]
                    ))
                }
            }
            complete?(false, nil)
        } catch {
            Logger.error(error)
            complete?(false, nil)
        }
    }

    func getStarRaillAllDailyNode() -> [StarRailWidgetDataModel] {
        var list: [StarRailWidgetDataModel] = []
        do {
            try dataBase.transaction {
                try dataBase.prepare(starRailDailyNode).forEach { item in
                    let account = StarRailWidgetDataModel(
                        currentStamina: item[currentStamina],
                        maxStamina: item[maxStamina],
                        staminaRecoverTime: item[staminaRecoverTime],
                        acceptedEpeditionNum: item[acceptedEpeditionNum],
                        totalExpeditionNum: item[totalExpeditionNum],
                        expeditions: item[expeditions],
                        currentTrainScore: item[currentTrainScore],
                        maxTrainScore: item[maxTrainScore],
                        currentRogueScore: item[currentRogueScore],
                        maxRogueScore: item[maxRogueScore],
                        weeklyCocoonCnt: item[weeklyCocoonCnt],
                        weeklyCocoonLimit: item[weeklyCocoonLimit],
                        currentReserveStamina: item[currentReserveStamina],
                        isReserveStaminaFull: item[isReserveStaminaFull]
                    )
                    list.append(account)
                }
            }
            return list
        } catch {
            Logger.error(error)
            return list
        }
    }
}
