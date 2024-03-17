//
//  SQLManager+DailyNode.swift
//  Barbatos
//
//  Created by Cain J H LUO_SP on 2022/10/24.
//

import Foundation
import SQLite

private let index                  = Expression<Int64>("index")                     // 索引
private let uid                    = Expression<String?>("uid")                     // 用户uid
private let currentResin           = Expression<Int?>("currentResin")               // 当前树脂数
private let maxResin               = Expression<Int?>("maxResin")                   // 最大树脂数
private let resinRecoveryTime      = Expression<String?>("resinRecoveryTime")       // 树脂回复时间
private let finishedTaskNum        = Expression<Int?>("finishedTaskNum")            // 完成日常数
private let totalTaskNum           = Expression<Int?>("totalTaskNum")               // 最大日常数
//private let remainResinDiscountNum = Expression<Int?>("remainResinDiscountNum")     // 可用周本数
//private let resinDiscountNumLimit  = Expression<Int?>("resinDiscountNumLimit")      // 最大周本数
private let isExtraTaskRewardReceived = Expression<Bool>("isExtraTaskRewardReceived")       // 是否已经获取每日委托后的额外奖励
private let currentExpeditionNum   = Expression<Int?>("currentExpeditionNum")       // 派遣数
private let maxExpeditionNum       = Expression<Int?>("maxExpeditionNum")           // 最大派遣数
private let expeditions            = Expression<String?>("expeditions")             // 派遣人数列表
private let currentHomeCoin        = Expression<Int?>("currentHomeCoin")            // 宝钱
private let maxHomeCoin            = Expression<Int?>("maxHomeCoin")                // 最大宝钱
//private let homeCoinRecoveryTime   = Expression<String?>("homeCoinRecoveryTime")    // 宝钱回复时间
//private let transformer            = Expression<String?>("transformer")             // 转换仪器

extension SQLManager {
    func createGenshinImpactWidgetTable(_ dataBase: Connection) {
        do {
            try dataBase.run(genshinImpactWidget.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid, unique: true)
                table.column(currentResin)
                table.column(maxResin)
                table.column(resinRecoveryTime)
                table.column(finishedTaskNum)
                table.column(totalTaskNum)
                table.column(isExtraTaskRewardReceived)
                table.column(currentExpeditionNum)
                table.column(maxExpeditionNum)
                table.column(expeditions)
                table.column(currentHomeCoin)
                table.column(maxHomeCoin)
            })
        } catch {
            #if DEBUG
            Logger.error(error)
            #endif
        }
    }

    func addGenshinImpactWidgetInfo(
        uuid: String,
        model: GenshinWidgetData,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let insert = genshinImpactWidget.insert(
                uid <- uuid,
                currentResin <- model.currentResin,
                maxResin <- model.maxResin,
                resinRecoveryTime <- model.resinRecoveryTime,
                finishedTaskNum <- model.finishedTaskNum,
                totalTaskNum <- model.totalTaskNum,
                isExtraTaskRewardReceived <- model.isExtraTaskRewardReceived,
                currentExpeditionNum <- model.currentExpeditionNum,
                maxExpeditionNum <- model.maxExpeditionNum,
                expeditions <- model.expeditions?.toJSONString(),
                currentHomeCoin <- model.currentHomeCoin,
                maxHomeCoin <- model.maxHomeCoin
            )
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            Logger.error(error)
            complete?(false, error)
        }
    }

    func updateGenshinImpactWidget(
        uuid: String,
        model: GenshinWidgetData,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let genshinImpactWidget = genshinImpactWidget.filter(
                    uid == uuid
                )
                try dataBase.run(genshinImpactWidget.update(
                    uid <- uuid,
                    currentResin <- model.currentResin,
                    maxResin <- model.maxResin,
                    resinRecoveryTime <- model.resinRecoveryTime,
                    finishedTaskNum <- model.finishedTaskNum,
                    totalTaskNum <- model.totalTaskNum,
                    isExtraTaskRewardReceived <- model.isExtraTaskRewardReceived,
                    currentExpeditionNum <- model.currentExpeditionNum,
                    maxExpeditionNum <- model.maxExpeditionNum,
                    expeditions <- model.expeditions?.toJSONString(),
                    currentHomeCoin <- model.currentHomeCoin,
                    maxHomeCoin <- model.maxHomeCoin
                ))
                complete?(true, nil)
            }
        } catch {
            Logger.error(error)
            complete?(false, error)
        }
    }

    func getGenshinImpactWidget(
        _ uuid: String,
        complete: ((Bool, GenshinWidgetData?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let query = genshinImpactWidget.filter(uid == uuid)
                try dataBase.prepare(query).forEach { item in
                    complete?(true, GenshinWidgetData(
                        currentResin: item[currentResin] ?? 0,
                        maxResin: item[maxResin] ?? 0,
                        resinRecoveryTime: item[resinRecoveryTime] ?? "",
                        finishedTaskNum: item[finishedTaskNum] ?? 0,
                        totalTaskNum: item[totalTaskNum] ?? 0,
                        isExtraTaskRewardReceived: item[isExtraTaskRewardReceived],
                        currentExpeditionNum: item[currentExpeditionNum] ?? 0,
                        maxExpeditionNum: item[maxExpeditionNum] ?? 0,
                        expeditions: item[expeditions],
                        currentHomeCoin: item[currentHomeCoin] ?? 0,
                        maxHomeCoin: item[maxHomeCoin] ?? 0
                    ))
                }
            }
            complete?(false, nil)
        } catch {
            Logger.error(error)
            complete?(false, nil)
        }
    }
}
