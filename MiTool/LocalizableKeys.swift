//
//  LocalizableKeys.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

typealias CopySideBar = LocalizableKeys.SideBar
typealias CopyStarRailWeight = LocalizableKeys.StarRailWeight
typealias CopyStarRailRole = LocalizableKeys.StarRailRole
typealias CopyGenshinWeight = LocalizableKeys.GenshinWeight
typealias CopyGameName = LocalizableKeys.MihoyoGameName

struct LocalizableKeys {
    struct SideBar {
        static let notesTitle = String(localized: "SideBarNotesTitle")
        static let usersTitle = String(localized: "SideBarUserTitle")

        static let genshinTitle = String(localized: "SideBarGenshinTitle")
        static let genshinHome = String(localized: "SideBarGenshinHome")
        static let genshinRole = String(localized: "SideBarGenshinRole")
        
        static let starRailTitle = String(localized: "SideBarStarRailTitle")
        static let starRailRole = String(localized: "SideBarStarRailRole")
        static let starRailMap = String(localized: "SideBarStarRailMap")
        static let starRailWiki = String(localized: "SideBarStarRailWiki")
    }
    
    struct StarRailWeight {
        static let daily = String(localized: "StarRailWeightDaily")
        static let weekly = String(localized: "StarRailWeightWeekly")
        static let entrusted = String(localized: "StarRailWeightEntrusted")
        static let weeklyMonster = String(localized: "StarRailWeightWeeklyMonster")
        static let recoveryTime = String(localized: "StarRailWeightRecoveryTime")
        static let trailblazePower = String(localized: "StarRailWeightTrailblazePower")
        static let reserveTrailblazePower = String(localized: "StarRailWeightTrailblazePower")
        static let reserveTrailblazePowerFull = String(localized: "StarRailWeightTrailblazePowerFull")
        static let fullYes = String(localized: "StarRailWeightTrailblazePowerYes")
        static let fullNo = String(localized: "StarRailWeightTrailblazePowerNo")
    }
    
    struct StarRailRole {
        static let avatarConsume = String(localized: "StarRailRoleAvatarConsume")
        static let skillsConsume = String(localized: "StarRailRoleSkillsConsume")
        static let equipmentConsume = String(localized: "StarRailRoleEquipmentConsume")
        static let finishedConsume = String(localized: "StarRailRoleConsumeFinished")
        
        static let equipmentTitle = String(localized: "StarRailRoleEquipmentTitle")        
    }
    
    struct GenshinWeight {
        static let resin = String(localized: "GenshinWeightResin")
        static let recoveryTime = String(localized: "GenshinWeightRecoveryTime")
        static let timeFormatter = String(localized: "GenshinWeightRecoveryTimeFormatter")
        static let minutesFormatter = String(localized: "GenshinWeightRecoveryMinutesFormatter")
        static let recoveryDone = String(localized: "GenshinWeightRecoveryDone")
        static let transformerDay = String(localized: "GenshinWeightTransformerDay")
        static let transformerHour = String(localized: "GenshinWeightTransformerHour")
        static let ready = String(localized: "GenshinWeightTransformerReady")
    }
    
    struct MihoyoGameName {
        static let honkai3 = String(localized: "MihoyoGameNameHonKai3")
        static let genshin = String(localized: "MihoyoGameNameGenshinImpact")
        static let starRail = String(localized: "MihoyoGameNameStarRail")
        static let uid = String(localized: "MihoyoGameUID")
        static let regionName = String(localized: "MihoyoGameRegionName")
        static let nickname = String(localized: "MihoyoGameNickname")
        static let level = String(localized: "MihoyoGameLevel")
        static let returnTitle = String(localized: "MihoyoGameReturn")
        static let inputNickname = String(localized: "MihoyoGameInputNickname")
        static let inpurUID = String(localized: "MihoyoGameInputUID")
        static let inputCookie = String(localized: "MihoyoGameInputCookie")
        static let save = String(localized: "MihoyoGameSave")
        static let region = String(localized: "MihoyoGameRegion")
        static let addUser = String(localized: "MihoyoGameAddUser")
    }
}

struct ApiURL {
    static let genshiHost = "https://api-takumi-record.mihoyo.com"
    
    struct GenshinImpact {
        static let genshinDaily = "\(genshiHost)/game_record/app/genshin/api/dailyNote"
    }
}

typealias IconSideBar = IconKeys.SideBar

struct IconKeys {
    struct SideBar {
        static let header = "person.circle.fill"
        static let home = "house.fill"
        static let roleList = "person.circle"
        static let map = "map.circle.fill"
        static let wiki = "book.circle.fill"
        static let starRailSection = "star.leadinghalf.filled"
    }
}

// https://honkai-star-rail.fandom.com/wiki/Guinaifen
// https://genshin-impact.fandom.com/wiki/Xianyun?file=Xianyun+Card.png

