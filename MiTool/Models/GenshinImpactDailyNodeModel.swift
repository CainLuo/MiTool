//
//  GenshinImpactDailyNodeModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/20.
//

import Foundation
import ObjectMapper

// MARK: - GenshinImpactDailyNodeModel
struct GenshinImpactDailyNodeModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: GenshinImpactDailyNodeData?
    
    init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - GenshinImpactDailyNodeData
struct GenshinImpactDailyNodeData: Mappable {
    // 当前体力
    var currentResin: Int = 0
    // 最大体力
    var maxResin: Int = 0
    // 恢复时间
    var resinRecoveryTime: String = ""
    // 已完成每日委托数量
    var finishedTaskNum: Int = 0
    // 总每日委托数量
    var totalTaskNum: Int = 0
    // 是否已经获取每日委托后的额外奖励
    var isExtraTaskRewardReceived: Bool = false
    // 剩余优惠周本次数
    var remainResinDiscountNum: Int = 0
    // 每周总共优惠周本次数
    var resinDiscountNumLimit: Int = 0
    // 当前派遣角色数量
    var currentExpeditionNum: Int = 0
    // 最大派遣角色数量
    var maxExpeditionNum: Int = 0
    // 派遣角色详情
    var expeditions: [GenshinImpactDailyNodeExpedition]?
    // 当前尘歌壶的金币
    var currentHomeCoin: Int = 0
    // 最大尘歌壶的金币
    var maxHomeCoin: Int = 0
    // 尘歌壶金币的恢复时间
    var homeCoinRecoveryTime: String = ""
    // 暂时未知
    var calendarURL: String = ""
    // 参量质变仪的恢复时间
    var transformer: GenshinImpactDailyNodeTransformer?
    // 每日委托的详情：委托任务、历练点
    var dailyTask: GenshinImpactDailyNodeDailyTask?
    // 魔神任务、支线任务详情
    var archonQuestProgress: GenshinImpactDailyNodeArchonQuestProgress?
    
    var transformerTime: String {
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
    
    init?(map: ObjectMapper.Map) { }
    init() { }

    mutating func mapping(map: ObjectMapper.Map) {
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

// MARK: - GenshinImpactDailyNodeArchonQuestProgress
struct GenshinImpactDailyNodeArchonQuestProgress: Mappable {
    var list: [Any?]?
    var isOpenArchonQuest: Bool = false
    var isFinishAllMainline: Bool = false
    var isFinishAllInterchapter: Bool = false
    var wikiURL: String = ""
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        list <- map["list"]
        isOpenArchonQuest <- map["is_open_archon_quest"]
        isFinishAllMainline <- map["is_finish_all_mainline"]
        isFinishAllInterchapter <- map["is_finish_all_interchapter"]
        wikiURL <- map["wiki_url"]
    }
}

// MARK: - GenshinImpactDailyNodeDailyTask
struct GenshinImpactDailyNodeDailyTask: Mappable {
    var totalNum: Int = 0
    var finishedNum: Int = 0
    var isExtraTaskRewardReceived: Bool = false
    var taskRewards: [GenshinImpactDailyNodeTaskReward]?
    var attendanceRewards: [GenshinImpactDailyNodeAttendanceReward]?
    var attendanceVisible: Bool = false
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        totalNum <- map["total_num"]
        finishedNum <- map["finished_num"]
        isExtraTaskRewardReceived <- map["is_extra_task_reward_received"]
        taskRewards <- map["task_rewards"]
        attendanceRewards <- map["attendance_rewards"]
        attendanceVisible <- map["attendance_visible"]
    }
}

// MARK: - GenshinImpactDailyNodeAttendanceReward
struct GenshinImpactDailyNodeAttendanceReward: Mappable {
    var status: String = ""
    var progress: Int = 0
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
        progress <- map["progress"]
    }
}

// MARK: - GenshinImpactDailyNodeTaskReward
struct GenshinImpactDailyNodeTaskReward: Mappable {
    var status: String = ""
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        status <- map["status"]
    }
}

// MARK: - GenshinImpactDailyNodeExpedition
struct GenshinImpactDailyNodeExpedition: Mappable, Identifiable {
    var id = UUID()
    var avatarSideIcon: String = ""
    var status: String = ""
    var remainedTime: String = ""
    
    var remainedTimeString: String {
        guard let remainedTime = Int(remainedTime) else {
            return ""
        }
        
        let tempMinute = remainedTime % 3600
        let minute = tempMinute / 60
        let hour = (remainedTime - tempMinute) / 3600
        return String(format: CopyGenshinWeight.transformerHour, hour, minute)
    }
    
    var timeProgress: CGFloat {
        guard let remainedTime = Int(remainedTime) else {
            return 0
        }
        if remainedTime == 0 {
            return 1
        } else {
            return (3600.0 / CGFloat(remainedTime))
        }
    }
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        avatarSideIcon <- map["avatar_side_icon"]
        status <- map["status"]
        remainedTime <- map["remained_time"]
    }
}

// MARK: - GenshinImpactDailyNodeTransformer
struct GenshinImpactDailyNodeTransformer: Mappable {
    var obtained: Bool = false
    var recoveryTime: GenshinImpactDailyNodeRecoveryTime?
    var wiki: String = ""
    var noticed: Bool = false
    var latestJobID: String = ""
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        obtained <- map["obtained"]
        recoveryTime <- map["recovery_time"]
        wiki <- map["wiki"]
        noticed <- map["noticed"]
        latestJobID <- map["latest_job_id"]
    }
}

// MARK: - GenshinImpactDailyNodeRecoveryTime
struct GenshinImpactDailyNodeRecoveryTime: Mappable {
    var day: Int = 0
    var hour: Int = 0
    var minute: Int = 0
    var second: Int = 0
    var reached: Bool = false
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        day <- map["Day"]
        hour <- map["Hour"]
        minute <- map["Minute"]
        second <- map["Second"]
        reached <- map["reached"]
    }
}
