//
//  GenshinWidgetModel.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import Foundation
import ObjectMapper

// MARK: - GenshinWidgetModel
public struct GenshinWidgetModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: GenshinWidgetData?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - GenshinWidgetData
public struct GenshinWidgetData: Mappable {
    // 当前体力
    public var currentResin: Int = 0
    // 最大体力
    public var maxResin: Int = 0
    // 恢复时间
    public var resinRecoveryTime: String = ""
    // 已完成每日委托数量
    public var finishedTaskNum: Int = 0
    // 总每日委托数量
    public var totalTaskNum: Int = 0
    // 是否已经获取每日委托后的额外奖励
    public var isExtraTaskRewardReceived = false
    // 当前派遣角色数量
    public var currentExpeditionNum: Int = 0
    // 最大派遣角色数量
    public var maxExpeditionNum: Int = 0
    // 派遣角色详情
    public var expeditions: [GenshinWidgetExpedition]?
    // 当前尘歌壶的金币
    public var currentHomeCoin: Int = 0
    // 最大尘歌壶的金币
    public var maxHomeCoin: Int = 0
    public var hasSigned = false
    public var signURL: String = ""
    public var dailyTask: GenshinDailyNodeDailyTask?
    public var homeURL: String = ""
    public var noteURL: String = ""

    public var resinContent: String {
        "\(currentResin)/\(maxResin)"
    }

    public init?(map: ObjectMapper.Map) { }
    init() { }
    
    init(
        currentResin: Int,
        maxResin: Int,
        resinRecoveryTime: String,
        finishedTaskNum: Int,
        totalTaskNum: Int,
        isExtraTaskRewardReceived: Bool,
        currentExpeditionNum: Int,
        maxExpeditionNum: Int,
        expeditions: String?,
        currentHomeCoin: Int,
        maxHomeCoin: Int
    ) {
        self.currentResin = currentResin
        self.maxResin = maxResin
        self.resinRecoveryTime = resinRecoveryTime
        self.finishedTaskNum = finishedTaskNum
        self.totalTaskNum = totalTaskNum
        self.isExtraTaskRewardReceived = isExtraTaskRewardReceived
        self.currentExpeditionNum = currentExpeditionNum
        self.maxExpeditionNum = maxExpeditionNum
        self.expeditions = [GenshinWidgetExpedition](JSONString: expeditions ?? "")
        self.currentHomeCoin = currentHomeCoin
        self.maxHomeCoin = maxHomeCoin
    }

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

// MARK: - GenshinWidgetExpedition
public struct GenshinWidgetExpedition: Mappable, Identifiable {
    public var id = UUID()
    public var avatarSideIcon: String = ""
    public var status: String?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatarSideIcon <- map["avatar_side_icon"]
        status <- map["status"]
    }
}
