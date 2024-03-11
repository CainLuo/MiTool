//
//  GenshinImpactWidgetModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import ObjectMapper

// MARK: - GenshinImpactWidgetModel
public struct GenshinImpactWidgetModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: GenshinImpactWidgetData?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - GenshinImpactWidgetData
public struct GenshinImpactWidgetData: Mappable {
    public var currentResin: Int?
    public var maxResin: Int?
    public var resinRecoveryTime: String?
    public var finishedTaskNum: Int?
    public var totalTaskNum: Int?
    public var isExtraTaskRewardReceived: Bool?
    public var currentExpeditionNum: Int?
    public var maxExpeditionNum: Int?
    public var expeditions: [GenshinImpactWidgetExpedition]?
    public var currentHomeCoin: Int?
    public var maxHomeCoin: Int?
    public var hasSigned: Bool?
    public var signURL: String?
    public var dailyTask: NSNull?
    public var homeURL: String?
    public var noteURL: String?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
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
public struct GenshinImpactWidgetExpedition: Mappable {
    public var avatarSideIcon: String?
    public var status: String?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatarSideIcon <- map["avatar_side_icon"]
        status <- map["status"]
    }
}
