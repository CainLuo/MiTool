//
//  StarRailDestinyTypes.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import Foundation

public enum StarRailDestinyTypes: String {
    case destruction = "1"     // 毁灭
    case theHunt = "2"         // 巡猎
    case erudition = "3"       // 智识
    case harmony = "4"         // 同谐
    case nihility = "5"        // 虚无
    case preservation = "6"    // 存护
    case abundance = "7"       // 丰饶

    public var destinyIcon: String {
        switch self {
        case .destruction:
            return StarRailDestinyIconName.destructionIcon.rawValue
        case .theHunt:
            return StarRailDestinyIconName.theHuntIcon.rawValue
        case .erudition:
            return StarRailDestinyIconName.eruditionIcon.rawValue
        case .harmony:
            return StarRailDestinyIconName.harmonyIcon.rawValue
        case .nihility:
            return StarRailDestinyIconName.nihilityIcon.rawValue
        case .preservation:
            return StarRailDestinyIconName.preservationIcon.rawValue
        case .abundance:
            return StarRailDestinyIconName.abundanceIcon.rawValue
        }
    }
}

public enum StarRailDestinyIconName: String {
    case destructionIcon = "destruction"      // 毁灭
    case theHuntIcon = "theHunt"              // 巡猎
    case eruditionIcon = "erudition"          // 智识
    case harmonyIcon = "harmony"              // 同谐
    case nihilityIcon = "nihility"            // 虚无
    case preservationIcon = "preservation"    // 存护
    case abundanceIcon = "abundance"          // 丰饶
}

