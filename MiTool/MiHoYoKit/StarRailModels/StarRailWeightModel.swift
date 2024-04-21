//
//  StarRailWidgetModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import Foundation
import ObjectMapper

// MARK: - StarRailWidgetModel
public struct StarRailWidgetModel: Mappable {
    public var retcode: Int?
    public var message: String?
    public var data: StarRailWidgetDataModel?
    
    public init?(map: ObjectMapper.Map) { }
    init() { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - StarRailWidgetDataModel
public struct StarRailWidgetDataModel: Mappable {
    // 当前体力
    public var currentStamina: Int = 0
    // 最大体力
    public var maxStamina: Int = 0
    // 恢复体力时间
    public var staminaRecoverTime: Int = 0
    // 探险数量
    public var acceptedEpeditionNum: Int = 0
    // 总的最大可探险数量
    public var totalExpeditionNum: Int = 0
    // 探险详情
    public var expeditions: [StarRailWidgetExpeditionModel]?
    // 当前当日活跃度
    public var currentTrainScore: Int = 0
    // 总的当日活跃度
    public var maxTrainScore: Int = 0
    // 本周积分
    public var currentRogueScore: Int = 0
    // 总的最大本周积分
    public var maxRogueScore: Int = 0
    // 当前可用历战余响次数
    public var weeklyCocoonCnt: Int = 0
    // 最大可用历战余响次数
    public var weeklyCocoonLimit: Int = 0
    // 当前体力储备
    public var currentReserveStamina: Int = 0
    // 是否有体力存储
    public var isReserveStaminaFull = false
    
    public init?(map: ObjectMapper.Map) { }
    
    init(
        currentStamina: Int,
        maxStamina: Int,
        staminaRecoverTime: Int,
        acceptedEpeditionNum: Int,
        totalExpeditionNum: Int,
        expeditions: String?,
        currentTrainScore: Int,
        maxTrainScore: Int,
        currentRogueScore: Int,
        maxRogueScore: Int,
        weeklyCocoonCnt: Int,
        weeklyCocoonLimit: Int,
        currentReserveStamina: Int,
        isReserveStaminaFull: Bool
    ) {
        self.currentStamina = currentStamina
        self.maxStamina = maxStamina
        self.staminaRecoverTime = staminaRecoverTime
        self.acceptedEpeditionNum = acceptedEpeditionNum
        self.totalExpeditionNum = totalExpeditionNum
        self.expeditions = [StarRailWidgetExpeditionModel](JSONString: expeditions ?? "")
        self.currentTrainScore = currentTrainScore
        self.maxTrainScore = maxTrainScore
        self.currentRogueScore = currentRogueScore
        self.maxRogueScore = maxRogueScore
        self.weeklyCocoonCnt = weeklyCocoonCnt
        self.weeklyCocoonLimit = weeklyCocoonLimit
        self.currentReserveStamina = currentReserveStamina
        self.isReserveStaminaFull = isReserveStaminaFull
    }
    
    mutating public func mapping(map: ObjectMapper.Map) {
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

public enum StarRailWidgetExpeditionStatus: String {
    case ongoing = "Ongoing"
    case finish = "Finished"
    
    // 原神：Finished
}

// MARK: - StarRailWidgetExpeditionModel
public struct StarRailWidgetExpeditionModel: Mappable, Identifiable {
    public var id = UUID()
    // 探险角色头像列表
    public var avatars: [String]?
    // 探险状态
    public var status: StarRailWidgetExpeditionStatus = .ongoing
    // 探险剩余时间
    public var remainingTime: Int = 0
    // 探险名称
    public var name: String = ""
    // 探险icon地址
    public var itemURL: String = ""
    
    public init?(map: ObjectMapper.Map) { }
    
    mutating public func mapping(map: ObjectMapper.Map) {
        avatars <- map["avatars"]
        status <- map["status"]
        remainingTime <- map["remaining_time"]
        name <- map["name"]
        itemURL <- map["item_url"]
    }
}
