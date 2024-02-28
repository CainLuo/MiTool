//
//  GenshinImpactWidgetModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import ObjectMapper

// MARK: - GenshinImpactWidgetModel
struct GenshinImpactWidgetModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: GenshinImpactWidgetData?
    
    init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - GenshinImpactWidgetData
struct GenshinImpactWidgetData {
    var currentResin: Int?
    var maxResin: Int?
    var resinRecoveryTime: String?
    var finishedTaskNum: Int?
    var totalTaskNum: Int?
    var isExtraTaskRewardReceived: Bool?
    var currentExpeditionNum: Int?
    var maxExpeditionNum: Int?
    var expeditions: [GenshinImpactWidgetExpedition]?
    var currentHomeCoin: Int?
    var maxHomeCoin: Int?
    var hasSigned: Bool?
    var signURL: String?
    var dailyTask: NSNull?
    var homeURL: String?
    var noteURL: String?
    
    init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        currentResin <- map["current_resin"]
        maxResin <- map["max_resin"]
        resinRecoveryTime <- map["resin_recovery_time"]
        finishedTaskNum <- map["finished_task_num"]
        totalTaskNum <- map["total_task_num"]
        isExtraTaskRewardReceived <- map["is_extra_task_reward_received"]
        currentExpeditionNum <- map["current_expedition_num"]
        maxExpeditionNum <- map["max_expedition_num"]
        expeditions <- map["expeditions"]
        currentHomeCoin <- map["current_home_coin"]
        maxHomeCoin <- map["max_home_coin"]
        hasSigned <- map["has_signed"]
        signURL <- map["sign_url"]
        dailyTask <- map["daily_task"]
        homeURL <- map["home_url"]
        noteURL <- map["note_url"]
    }
}

// MARK: - GenshinImpactWidgetExpedition
struct GenshinImpactWidgetExpedition {
    var avatarSideIcon: String?
    var status: String?
    
    init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        avatarSideIcon <- map["avatar_side_icon"]
        status <- map["status"]
    }
}
