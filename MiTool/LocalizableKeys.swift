//
//  LocalizableKeys.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

typealias CopySideBar = LocalizableKeys.SideBar
typealias CopyStarRailWidget = LocalizableKeys.StarRailWidget
typealias CopyStarRailRole = LocalizableKeys.StarRailRole
typealias CopyGenshinWidget = LocalizableKeys.GenshinWidget
typealias CopyGameName = LocalizableKeys.MihoyoGameName

// swiftlint: disable convenience_type
struct LocalizableKeys {
    struct SideBar {
        static let notesTitle = String(localized: "SideBarNotesTitle")
        static let usersTitle = String(localized: "SideBarUserTitle")

        static let genshinTitle = String(localized: "SideBarGenshinTitle")
        static let genshinRole = String(localized: "SideBarGenshinRole")
        static let genshinMap = String(localized: "SideBarGenshinMap")
        static let genshinWiki = String(localized: "SideBarGenshinWiki")

        static let starRailTitle = String(localized: "SideBarStarRailTitle")
        static let starRailRole = String(localized: "SideBarStarRailRole")
        static let starRailMap = String(localized: "SideBarStarRailMap")
        static let starRailWiki = String(localized: "SideBarStarRailWiki")
    }

    struct StarRailWidget {
        static let daily = String(localized: "StarRailWidgetDaily")
        static let weekly = String(localized: "StarRailWidgetWeekly")
        static let entrusted = String(localized: "StarRailWidgetEntrusted")
        static let weeklyMonster = String(localized: "StarRailWidgetWeeklyMonster")
        static let recoveryTime = String(localized: "StarRailWidgetRecoveryTime")
        static let trailblazePower = String(localized: "StarRailWidgetTrailblazePower")
        static let reserveTrailblazePower = String(localized: "StarRailWidgetTrailblazePower")
        static let reserveTrailblazePowerFull = String(localized: "StarRailWidgetTrailblazePowerFull")
        static let fullYes = String(localized: "StarRailWidgetTrailblazePowerYes")
        static let fullNo = String(localized: "StarRailWidgetTrailblazePowerNo")
        static let finished = String(localized: "StarRailWidgetWeightFinished")
    }

    struct StarRailRole {
        static let avatarConsume = String(localized: "StarRailRoleAvatarConsume")
        static let skillsConsume = String(localized: "StarRailRoleSkillsConsume")
        static let equipmentConsume = String(localized: "StarRailRoleEquipmentConsume")
        static let finishedConsume = String(localized: "StarRailRoleConsumeFinished")
        static let equipmentTitle = String(localized: "StarRailRoleEquipmentTitle")
    }

    struct GenshinWidget {
        static let resin = String(localized: "GenshinWidgetResin")
        static let recoveryTime = String(localized: "GenshinWidgetRecoveryTime")
        static let recoveryDone = String(localized: "GenshinWidgetRecoveryDone")
        static let transformerDay = String(localized: "GenshinWidgetTransformerDay")
        static let transformerHour = String(localized: "GenshinWidgetTransformerHour")
        static let transformerMinutes = String(localized: "GenshinWidgetTransformerMinutes")
        static let ready = String(localized: "GenshinWidgetTransformerReady")
        static let date = String(localized: "GenshinWidgetTransformerDate")
        static let constellation = String(localized: "GenshinRoleConstellation")
        static let affix = String(localized: "GenshinRoleAffix")
    }

    struct MihoyoGameName {
        static let honkai3 = String(localized: "MihoyoGameNameHonKai3")
        static let genshin = String(localized: "MihoyoGameNameGenshinImpact")
        static let starRail = String(localized: "MihoyoGameNameStarRail")
        static let unknown = String(localized: "MihoyoGameNameUnknown")
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
        static let sToken = String(localized: "MihoyoGameSToken")
        static let deviceFP = String(localized: "MihoyoGameDeivceFP")
    }
}

// https://honkai-star-rail.fandom.com/wiki/Guinaifen
// https://genshin-impact.fandom.com/wiki/Xianyun?file=Xianyun+Card.png
