//
//  StarRailWeightModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import Foundation
import ObjectMapper

// MARK: - StarRailWeightModel
struct StarRailWeightModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: StarRailWeightDataModel?
    
    init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailWeightDataModel
struct StarRailWeightDataModel: Mappable {
    // 当前体力
    var currentStamina: Int = 0
    // 最大体力
    var maxStamina: Int = 0
    // 恢复体力时间
    var staminaRecoverTime: Int = 0
    // 探险数量
    var acceptedEpeditionNum: Int = 0
    // 总的最大可探险数量
    var totalExpeditionNum: Int = 0
    // 探险详情
    var expeditions: [StarRailWeightExpeditionModel]?
    // 当前当日活跃度
    var currentTrainScore: Int = 0
    // 总的当日活跃度
    var maxTrainScore: Int = 0
    // 本周积分
    var currentRogueScore: Int = 0
    // 总的最大本周积分
    var maxRogueScore: Int = 0
    // 当前可用历战余响次数
    var weeklyCocoonCnt: Int = 0
    // 最大可用历战余响次数
    var weeklyCocoonLimit: Int = 0
    // 当前体力储备
    var currentReserveStamina: Int = 0
    // 是否有体力存储
    var isReserveStaminaFull: Bool = false
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        currentStamina <- map["current_stamina"]
        maxStamina <- map["max_stamina"]
        staminaRecoverTime <- map["stamina_recover_time"]
        acceptedEpeditionNum <- map["accepted_epedition_num"]
        totalExpeditionNum <- map["total_expedition_num"]
        expeditions <- map["expeditions"]
        currentTrainScore <- map["current_train_score"]
        maxTrainScore <- map["max_train_score"]
        currentRogueScore <- map["current_rogue_score"]
        maxRogueScore <- map["max_rogue_score"]
        weeklyCocoonCnt <- map["weekly_cocoon_cnt"]
        weeklyCocoonLimit <- map["weekly_cocoon_limit"]
        currentReserveStamina <- map["current_reserve_stamina"]
        isReserveStaminaFull <- map["is_reserve_stamina_full"]
    }
}

enum StarRailWeightExpeditionStatus: String {
    case ongoing = "Ongoing"
    case finish = "Finished"
    
    // 原神：Finished
}

// MARK: - StarRailWeightExpeditionModel
struct StarRailWeightExpeditionModel: Mappable, Identifiable {
    var id = UUID()
    // 探险角色头像列表
    var avatars: [String]?
    // 探险状态
    var status: StarRailWeightExpeditionStatus = .ongoing
    // 探险剩余时间
    var remainingTime: Int = 0
    // 探险名称
    var name: String = ""
    // 探险icon地址
    var itemURL: String = ""
    
    var timeString: String {
        if remainingTime == 0 {
            return "已完成"
        } else if remainingTime < 3600 {
            let minutes = remainingTime / 60
            return "0小时\(minutes)分钟"
        } else {
            let minutes = remainingTime % 3600 / 60
            let hour = Int(remainingTime / 3600)
            return "\(hour)小时\(minutes)分钟"
        }
    }
    
    var timeProgress: CGFloat {
        if remainingTime == 0 {
            return 1
        } else {
            return (3600.0 / CGFloat(remainingTime))
        }
    }
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        avatars <- map["avatars"]
        status <- map["status"]
        remainingTime <- map["remaining_time"]
        name <- map["name"]
        itemURL <- map["item_url"]
    }
}

enum StarRailLocalType {
    case daily
    case weekly
    case entrusted
    case weeklyMonster
}

struct StarRailLocalModel: Identifiable, Hashable {
    var id = UUID()
    var type: StarRailLocalType
    var currentValue: Int = 0
    var maxValue: Int = 0
    
    var name: String {
        switch type {
        case .daily:
            return CopyStarRailWeight.daily
        case .weekly:
            return CopyStarRailWeight.weekly
        case .entrusted:
            return CopyStarRailWeight.entrusted
        case .weeklyMonster:
            return CopyStarRailWeight.weeklyMonster
        }
    }
}
