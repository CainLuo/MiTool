//
//  SQLManager+DailyNode.swift
//  Barbatos
//
//  Created by Cain J H LUO_SP on 2022/10/24.
//

import Foundation
import SQLite
import ObjectMapper

private let index                  = Expression<Int64>("index")                     // 索引
private let uid                    = Expression<String?>("uid")                     // 用户uid
private let currentResin           = Expression<Int?>("currentResin")               // 当前树脂数
private let maxResin               = Expression<Int?>("maxResin")                   // 最大树脂数
private let resinRecoveryTime      = Expression<String?>("resinRecoveryTime")       // 树脂回复时间
private let finishedTaskNum        = Expression<Int?>("finishedTaskNum")            // 完成日常数
private let totalTaskNum           = Expression<Int?>("totalTaskNum")               // 最大日常数
private let remainResinDiscountNum = Expression<Int?>("remainResinDiscountNum")     // 可用周本数
private let resinDiscountNumLimit  = Expression<Int?>("resinDiscountNumLimit")      // 最大周本数
private let currentExpeditionNum   = Expression<Int?>("currentExpeditionNum")       // 派遣数
private let maxExpeditionNum       = Expression<Int?>("maxExpeditionNum")           // 最大派遣数
private let expeditions            = Expression<String?>("expeditions")             // 派遣人数列表
private let currentHomeCoin        = Expression<Int?>("currentHomeCoin")            // 宝钱
private let maxHomeCoin            = Expression<Int?>("maxHomeCoin")                // 最大宝钱
private let homeCoinRecoveryTime   = Expression<String?>("homeCoinRecoveryTime")    // 宝钱回复时间
private let transformer            = Expression<String?>("transformer")             // 转换仪器

extension SQLManager {
    func createGenshinImpactWidgetTable(_ dataBase: Connection) {
        do {
            try dataBase.run(genshinImpactWidget.create(ifNotExists: true) { t in
                t.column(index, primaryKey: .autoincrement)
                t.column(uid, unique: true)
                t.column(currentResin)
                t.column(maxResin)
                t.column(resinRecoveryTime)
                t.column(finishedTaskNum)
                t.column(totalTaskNum)
                t.column(remainResinDiscountNum)
                t.column(resinDiscountNumLimit)
                t.column(currentExpeditionNum)
                t.column(maxExpeditionNum)
                t.column(expeditions)
                t.column(currentHomeCoin)
                t.column(maxHomeCoin)
                t.column(homeCoinRecoveryTime)
                t.column(transformer)
            })
        } catch {
            #if DEBUG
            Logger.error(message: error)
            #endif
        }
    }

//    func insertRecord(into dataBase: Connection, record: YourRecordType) {
//        do {
//            let insert = genshinImpactWidget.insert(
//                index <- record.index,
//                uid <- record.uid,
//                currentResin <- record.currentResin,
//                maxResin <- record.maxResin,
//                resinRecoveryTime <- record.resinRecoveryTime,
//                finishedTaskNum <- record.finishedTaskNum,
//                totalTaskNum <- record.totalTaskNum,
//                remainResinDiscountNum <- record.remainResinDiscountNum,
//                resinDiscountNumLimit <- record.resinDiscountNumLimit,
//                currentExpeditionNum <- record.currentExpeditionNum,
//                maxExpeditionNum <- record.maxExpeditionNum,
//                expeditions <- record.expeditions,
//                currentHomeCoin <- record.currentHomeCoin,
//                maxHomeCoin <- record.maxHomeCoin,
//                homeCoinRecoveryTime <- record.homeCoinRecoveryTime,
//                transformer <- record.transformer
//            )
//            try dataBase.run(insert)
//        } catch {
//            print("Insert record failed: \(error)")
//        }
//    }

//    func updateRecord(in dataBase: Connection, record: YourRecordType) {
//        do {
//            let update = genshinImpactWidget.filter(index == record.index).update(
//                uid <- record.uid,
//                currentResin <- record.currentResin,
//                maxResin <- record.maxResin,
//                resinRecoveryTime <- record.resinRecoveryTime,
//                finishedTaskNum <- record.finishedTaskNum,
//                totalTaskNum <- record.totalTaskNum,
//                remainResinDiscountNum <- record.remainResinDiscountNum,
//                resinDiscountNumLimit <- record.resinDiscountNumLimit,
//                currentExpeditionNum <- record.currentExpeditionNum,
//                maxExpeditionNum <- record.maxExpeditionNum,
//                expeditions <- record.expeditions,
//                currentHomeCoin <- record.currentHomeCoin,
//                maxHomeCoin <- record.maxHomeCoin,
//                homeCoinRecoveryTime <- record.homeCoinRecoveryTime,
//                transformer <- record.transformer
//            )
//            try dataBase.run(update)
//        } catch {
//            print("Update record failed: \(error)")
//        }
//    }

//    func getRecord(forUid uidValue: String, from dataBase: Connection) async -> YourRecordType? {
//        do {
//            let query = genshinImpactWidget.filter(uid == uidValue)
//            if let record = try await dataBase.pluck(query) {
//                return YourRecordType(
//                    index: record[index],
//                    uid: record[uid],
//                    currentResin: record[currentResin],
//                    maxResin: record[maxResin],
//                    resinRecoveryTime: record[resinRecoveryTime],
//                    finishedTaskNum: record[finishedTaskNum],
//                    totalTaskNum: record[totalTaskNum],
//                    remainResinDiscountNum: record[remainResinDiscountNum],
//                    resinDiscountNumLimit: record[resinDiscountNumLimit],
//                    currentExpeditionNum: record[currentExpeditionNum],
//                    maxExpeditionNum: record[maxExpeditionNum],
//                    expeditions: record[expeditions],
//                    currentHomeCoin: record[currentHomeCoin],
//                    maxHomeCoin: record[maxHomeCoin],
//                    homeCoinRecoveryTime: record[homeCoinRecoveryTime],
//                    transformer: record[transformer]
//                )
//            } else {
//                return nil
//            }
//        } catch {
//            print("Query failed: \(error)")
//            return nil
//        }
//    }
    
//    func getAllRecords(from dataBase: Connection) -> [YourRecordType] {
//        var records: [YourRecordType] = []
//
//        do {
//            let query = genshinImpactWidget
//            for row in try dataBase.prepare(query) {
//                let record = YourRecordType(
//                    index: row[index],
//                    uid: row[uid],
//                    currentResin: row[currentResin],
//                    maxResin: row[maxResin],
//                    resinRecoveryTime: row[resinRecoveryTime],
//                    finishedTaskNum: row[finishedTaskNum],
//                    totalTaskNum: row[totalTaskNum],
//                    remainResinDiscountNum: row[remainResinDiscountNum],
//                    resinDiscountNumLimit: row[resinDiscountNumLimit],
//                    currentExpeditionNum: row[currentExpeditionNum],
//                    maxExpeditionNum: row[maxExpeditionNum],
//                    expeditions: row[expeditions],
//                    currentHomeCoin: row[currentHomeCoin],
//                    maxHomeCoin: row[maxHomeCoin],
//                    homeCoinRecoveryTime: row[homeCoinRecoveryTime],
//                    transformer: row[transformer]
//                )
//                records.append(record)
//            }
//        } catch {
//            print("Query all records failed: \(error)")
//        }
//
//        return records
//    }

//    func deleteRecord(in dataBase: Connection, index: Int) {
//        do {
//            let delete = genshinImpactWidget.filter(self.index == index).delete()
//            try dataBase.run(delete)
//        } catch {
//            print("Delete record failed: \(error)")
//        }
//    }

//    func deleteAllRecords(from dataBase: Connection) {
//        do {
//            let delete = genshinImpactWidget.delete()
//            try dataBase.run(delete)
//        } catch {
//            print("Delete all records failed: \(error)")
//        }
//    }
}
