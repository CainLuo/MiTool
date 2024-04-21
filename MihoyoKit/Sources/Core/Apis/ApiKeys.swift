//
//  ApiKeys.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import Foundation

enum ApiKeys {
    enum Host: String {
        case stokenV2 = "https://passport-api.mihoyo.com"
        case takumiRecord = "https://api-takumi-record.mihoyo.com"
        case bbsMihoyo = "https://bbs-api.miyoushe.com"
        case enka = ""
        case takumi = "https://api-takumi.mihoyo.com"
    }
    
    enum Mihoyo: String {
        // 获取米游社用户的游戏记录
        case gameRecord = "/game_record/card/api/getGameRecordCard"
        case userFullInfo = "/user/api/getUserFullInfo"
        
        case login = "https://m.bbs.mihoyo.com/ys/#/login"
        case stoken = "/account/ma-cn-session/app/getTokenBySToken"
        case cookieToken = "/auth/api/getCookieAccountInfoBySToken"
        // 获取游戏信息
        case gameRoles = "/binding/api/getUserGameRolesByCookie"
    }

    enum GenshinImpact: String {
        // 小组件
        case widget = "/game_record/app/genshin/aapi/widget/v2"
        // 实时便签
        case dailyNote = "/game_record/app/genshin/api/dailyNote"
        // 已抽取到的角色
        case character = "/game_record/app/genshin/api/character"
        // 原神所有的角色
        case avatarList = "/event/e20200928calculate/v1/avatar/list"
        // 原神所有的 filter, 角色属性, 武器类型
        case filterList = "/event/e20200928calculate/v1/item/filter"
        // 获取角色的天赋培养材料
        case avatarSkill = "/event/e20200928calculate/v1/avatarSkill/list"
        // 计算角色/武器的天赋培养材料
        case compute = "/event/e20200928calculate/v2/compute"
        // 获取深渊记录
        case spiralAbyss = "/game_record/app/genshin/api/spiralAbyss"
        // 获取角色的详细信息
        case roleDetail = "/event/e20200928calculate/v1/sync/avatar/detail"
        // 获取原神所有武器
        case weapons = "/event/e20200928calculate/v1/weapon/list"
    }

    enum StarRail: String {
        // 小组件
        case widget = "/game_record/app/hkrpg/aapi/widget?game=hkrpg"
        // 实时便签
        case dailyNote = "/game_record/app/hkrpg/api/note"
        // 已抽取到的角色
        case character = "/game_record/app/hkrpg/api/avatar/basic"
        // 星穹铁道所有的角色
        case avatarList = "/event/rpgcalc/avatar/list"
        // 星穹铁道角色详情（等级，行迹，光锥）
        case avatarDetail = "/event/rpgcalc/avatar/detail"
        // 星穹铁道所有光锥
        case equipmentList = "/event/rpgcalc/equipment/list"
        // 计算角色培养耗材, 等级, 行迹, 光锥
        case compute = "/event/rpgcalc/compute"
        // 模拟宇宙
        case rogue = "/game_record/app/hkrpg/api/rogue"
        // 混沌回忆
        case challenge = "/game_record/app/hkrpg/api/challenge"
    }
}