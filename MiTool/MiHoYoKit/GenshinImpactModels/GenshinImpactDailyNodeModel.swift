//
//  GenshinImpactDailyNodeModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/20.
//

import Foundation
import ObjectMapper

// MARK: - GenshinImpactDailyNodeModel
public struct GenshinImpactDailyNodeModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: GenshinImpactDailyNodeData?

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - GenshinImpactDailyNodeData
public struct GenshinImpactDailyNodeData: Mappable {
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
    // 剩余优惠周本次数
    public var remainResinDiscountNum: Int = 0
    // 每周总共优惠周本次数
    public var resinDiscountNumLimit: Int = 0
    // 当前派遣角色数量
    public var currentExpeditionNum: Int = 0
    // 最大派遣角色数量
    public var maxExpeditionNum: Int = 0
    // 派遣角色详情
    public var expeditions: [GenshinImpactDailyNodeExpedition]?
    // 当前尘歌壶的金币
    public var currentHomeCoin: Int = 0
    // 最大尘歌壶的金币
    public var maxHomeCoin: Int = 0
    // 尘歌壶金币的恢复时间
    public var homeCoinRecoveryTime: String = ""
    // 暂时未知
    public var calendarURL: String = ""
    // 参量质变仪的恢复时间
    public var transformer: GenshinImpactDailyNodeTransformer?
    // 每日委托的详情：委托任务、历练点
    public var dailyTask: GenshinImpactDailyNodeDailyTask?
    // 魔神任务、支线任务详情
    public var archonQuestProgress: GenshinImpactArchonQuestProgress?
    
    public var resinContent: String {
        "\(currentResin)/\(maxResin)"
    }

    public var transformerTime: String {
        guard let recoveryTime = transformer?.recoveryTime else {
            return ""
        }

        if recoveryTime.reached {
            return CopyGenshinWeight.ready
        } else {
            if recoveryTime.day > 0 {
                return String(format: CopyGenshinWeight.transformerDay, recoveryTime.day, recoveryTime.hour)
            } else {
                return String(format: CopyGenshinWeight.transformerHour, recoveryTime.hour, recoveryTime.minute)
            }
        }
    }

    public init?(map: ObjectMapper.Map) { }
    init() { }

    mutating public func mapping(map: ObjectMapper.Map) {
        currentResin <- map["current_resin"]
        maxResin <- map["max_resin"]
        resinRecoveryTime <- map["resin_recovery_time"]
        finishedTaskNum <- map["finished_task_num"]
        totalTaskNum <- map["total_task_num"]
        isExtraTaskRewardReceived <- map["is_extra_task_reward_received"]
        remainResinDiscountNum <- map["remain_resin_discount_num"]
        resinDiscountNumLimit <- map["resin_discount_num_limit"]
        currentExpeditionNum <- map["current_expedition_num"]
        maxExpeditionNum <- map["max_expedition_num"]
        expeditions <- map["expeditions"]
        currentHomeCoin <- map["current_home_coin"]
        maxHomeCoin <- map["max_home_coin"]
        homeCoinRecoveryTime <- map["home_coin_recovery_time"]
        calendarURL <- map["calendar_url"]
        transformer <- map["transformer"]
        dailyTask <- map["daily_task"]
        archonQuestProgress <- map["archon_quest_progress"]
    }
}

// MARK: - GenshinImpactArchonQuestProgress
public struct GenshinImpactArchonQuestProgress: Mappable {
    public var list: [Any?]?
    public var isOpenArchonQuest = false
    public var isFinishAllMainline = false
    public var isFinishAllInterchapter = false
    public var wikiURL: String = ""

    public init?(map: ObjectMapper.Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        list <- map["list"]
        isOpenArchonQuest <- map["is_open_archon_quest"]
        isFinishAllMainline <- map["is_finish_all_mainline"]
        isFinishAllInterchapter <- map["is_finish_all_interchapter"]
        wikiURL <- map["wiki_url"]
    }
}

// MARK: - GenshinImpactDailyNodeDailyTask
public struct GenshinImpactDailyNodeDailyTask: Mappable {
    public var totalNum: Int = 0
    public var finishedNum: Int = 0
    public var isExtraTaskRewardReceived = false
    public var taskRewards: [GenshinImpactDailyNodeTaskReward]?
    public var attendanceRewards: [GenshinImpactDailyNodeAttendanceReward]?
    public var attendanceVisible = false

    public init?(map: ObjectMapper.Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        totalNum <- map["total_num"]
        finishedNum <- map["finished_num"]
        isExtraTaskRewardReceived <- map["is_extra_task_reward_received"]
        taskRewards <- map["task_rewards"]
        attendanceRewards <- map["attendance_rewards"]
        attendanceVisible <- map["attendance_visible"]
    }
}

// MARK: - GenshinImpactDailyNodeAttendanceReward
public struct GenshinImpactDailyNodeAttendanceReward: Mappable {
    public var status: String = ""
    public var progress: Int = 0

    public init?(map: ObjectMapper.Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        progress <- map["progress"]
    }
}

// MARK: - GenshinImpactDailyNodeTaskReward
public struct GenshinImpactDailyNodeTaskReward: Mappable {
    public var status: String = ""

    public init?(map: ObjectMapper.Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
    }
}

// MARK: - GenshinImpactDailyNodeExpedition
public struct GenshinImpactDailyNodeExpedition: Mappable, Identifiable {
    public var id = UUID()
    public var avatarSideIcon: String = ""
    public var status: String = ""
    public var remainedTime: String = ""

    public var remainedTimeString: String {
        guard let remainedTime = Int(remainedTime) else {
            return ""
        }

        let tempMinute = remainedTime % 3600
        let minute = tempMinute / 60
        let hour = (remainedTime - tempMinute) / 3600
        return String(format: CopyGenshinWeight.transformerHour, hour, minute)
    }

    public var timeProgress: CGFloat {
        guard let remainedTime = Int(remainedTime) else {
            return 0
        }
        if remainedTime == 0 {
            return 1
        } else {
            return (3600.0 / CGFloat(remainedTime))
        }
    }

    public init?(map: ObjectMapper.Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        avatarSideIcon <- map["avatar_side_icon"]
        status <- map["status"]
        remainedTime <- map["remained_time"]
    }
}

// MARK: - GenshinImpactDailyNodeTransformer
public struct GenshinImpactDailyNodeTransformer: Mappable {
    public var obtained = false
    public var recoveryTime: GenshinImpactDailyNodeRecoveryTime?
    public var wiki: String = ""
    public var noticed = false
    public var latestJobID: String = ""

    public init?(map: ObjectMapper.Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        obtained <- map["obtained"]
        recoveryTime <- map["recovery_time"]
        wiki <- map["wiki"]
        noticed <- map["noticed"]
        latestJobID <- map["latest_job_id"]
    }
}

// MARK: - GenshinImpactDailyNodeRecoveryTime
public struct GenshinImpactDailyNodeRecoveryTime: Mappable {
    public var day: Int = 0
    public var hour: Int = 0
    public var minute: Int = 0
    public var second: Int = 0
    public var reached = false

    public init?(map: ObjectMapper.Map) { }

    mutating public func mapping(map: ObjectMapper.Map) {
        day <- map["Day"]
        hour <- map["Hour"]
        minute <- map["Minute"]
        second <- map["Second"]
        reached <- map["reached"]
    }
}

// MARK:
public struct GenshinImpactLocalDailyModel: Identifiable {
    public var id = UUID()
    public var iconNmae: String
    public var currentValue: Int = 0
    public var maxValue: Int = 0
    public var valueContent: String {
        "\(currentValue)/\(maxValue)"
    }
    public var otherContent: String? = nil
}
