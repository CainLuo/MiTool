//
//  ShowRoleCardModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/8.
//

import Foundation
import ObjectMapper

// MARK: - ShowRoleCardModel
struct ShowRoleCardModel {
    // 玩家详细信息字段
    // 当前返回结果仅包含此字段
    var detailInfo: ShowRoleUserInfoModel?
}

// MARK: - DetailInfo
struct ShowRoleUserInfoModel {
    // 平台信息
    var platform: String?
    // 数据信息
    var recordInfo: RecordInfo?
    // 昵称
    var nickname: String?
    // 是否公开显示角色信息
    var isDisplayAvatar: Bool?
    // 使用头像id
    var headIcon: Int?
    // 账号等级
    var level: Int?
    // 展示角色（星海同行）信息
    // 若未设置则不返回此字段
    var avatarDetailList: [ShowRoleListModel]?
    // 游戏 uid
    var uid: Int?
    // 当前好友数量
    var friendCount: Int?
    // 均衡等级 / 世界等级
    var worldLevel: Int?
    // 支援角色信息
    var assistAvatarList: [AssistAvatarList]?
}

// MARK: - AssistAvatarList
struct AssistAvatarList {
    // 遗器信息
    var relicList: [RelicList]?
    // 行迹 / 技能树信息
    var skillTreeList: [ShowRoleSkillModel]?
    // 角色id
    var avatarID: Int?
    // 角色等级
    var level: Int?
    // 角色晋阶等级
    var promotion: Int?
    // 光锥信息 若无光锥此项为 {}
    var equipment: ShowRoleWeaponModel?
    // 角色星魂数 若未解锁星魂则无此字段
    var rank: Int?
}

// MARK: - Equipment
struct ShowRoleWeaponModel {
    // 光锥晋阶等级
    var promotion: Int?
    // 光锥叠影数
    var rank: Int?
    // 光锥id
    var tid: Int?
    // 光锥等级
    var level: Int?
}

// MARK: - RelicList
struct RelicList {
    // 遗器等级
    var level: Int?
    // 遗器类型 1-HEAD 2-HAND 3-BODY 4-FOOT 5-NECK 6-OBJECT
    var type: Int?
    // 遗器主词条id 需要在遗器主词条组的索引
    var mainAffixID: Int?
    // 副词条
    var subAffixList: [SubAffixList]?
    // 遗器id
    var tid: Int?
    // 当前经验
    var exp: Int?
}

// MARK: - SubAffixList
struct SubAffixList {
    // 副词条id
    var affixID: Int?
    // 副词条基础值数量
    var cnt: Int?
    // 副词条步进值数量 可选
    var step: Int?
}

// MARK: - SkillTreeList
struct ShowRoleSkillModel {
    // 行迹id
    var pointID: Int?
    // 行迹等级
    var level: Int?
}

// MARK: - ShowRoleListModel
struct ShowRoleListModel {
    // 遗器信息
    var relicList: [RelicList]?
    // 行迹 / 技能树信息
    var skillTreeList: [ShowRoleSkillModel]?
    // 角色id
    var avatarID: Int?
    // 角色等级
    var level: Int?
    // 角色晋阶等级
    var promotion: Int?
    // 光锥信息 若无光锥此项为 {}
    var equipment: ShowRoleWeaponModel?
    // 角色位置
    var pos: Int?
    // 角色星魂数 若未解锁星魂则无此字段
    var rank: Int?
}

// MARK: - RecordInfo
struct RecordInfo {
    // 获得光锥数量
    var equipmentCount: Int?
    // 获得角色数量
    var avatarCount: Int?
    // 通过模拟宇宙数量
    var maxRogueChallengeScore: Int?
    var challengeInfo: ChallengeInfo?
    // 获得成就数量
    var achievementCount: Int?
}

// MARK: - ChallengeInfo
struct ChallengeInfo {
    var scheduleGroupID: Int?
    var noneScheduleMaxLevel: Int?
    var scheduleMaxLevel: Int?
}
