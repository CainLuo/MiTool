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

//extension SQLManager {
//
//    func createDailyNodeTable(_ db: Connection) {
//        do {
//            try db.run(dailyNodes.create(ifNotExists: true) { t in
//                t.column(index, primaryKey: .autoincrement)
//                
//                t.column(uid, unique: true)
//                t.column(currentResin)
//                t.column(maxResin)
//                t.column(resinRecoveryTime)
//                t.column(finishedTaskNum)
//                t.column(totalTaskNum)
//                t.column(remainResinDiscountNum)
//                t.column(resinDiscountNumLimit)
//                t.column(currentExpeditionNum)
//                t.column(maxExpeditionNum)
//                t.column(expeditions)
//                t.column(currentHomeCoin)
//                t.column(maxHomeCoin)
//                t.column(homeCoinRecoveryTime)
//                t.column(transformer)
//            })
//        } catch {
//            #if DEBUG
//            log.error(error)
//            #endif
//        }
//    }
//        
//    func getDailyNodes() -> [DailyNodeData] {
//        var nodes: [DailyNodeData] = []
//        
//        do {
//            try db.transaction {
//                try db.prepare(dailyNodes).forEach({ node in
//                    var expeditionList: [DailyNodeExpedition] = []
//                    if let expeditionsString = node[expeditions],
//                        let data = expeditionsString.data(using: .utf8),
//                       let jsonArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]] {
//                        expeditionList = jsonArray.compactMap { DailyNodeExpedition(JSON: $0) }
//                    }
//                    let node = DailyNodeData(uid: node[uid] ?? "",
//                                             currentResin: node[currentResin],
//                                             maxResin: node[maxResin],
//                                             resinRecoveryTime: node[resinRecoveryTime],
//                                             finishedTaskNum: node[finishedTaskNum],
//                                             totalTaskNum: node[totalTaskNum],
//                                             remainResinDiscountNum: node[remainResinDiscountNum],
//                                             resinDiscountNumLimit: node[resinDiscountNumLimit],
//                                             currentExpeditionNum: node[currentExpeditionNum],
//                                             maxExpeditionNum: node[maxExpeditionNum],
//                                             expeditions: expeditionList,
//                                             currentHomeCoin: node[currentHomeCoin],
//                                             maxHomeCoin: node[maxHomeCoin],
//                                             homeCoinRecoveryTime: node[homeCoinRecoveryTime],
//                                             transformer: DailyNodeTransformer(JSONString: node[transformer] ?? ""))
//                    nodes.append(node)
//                })
//            }
//            return nodes
//        } catch {
//            return []
//        }
//    }
//}
