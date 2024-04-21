//
//  StarRailDamageTypes.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import Foundation

public enum StarRailDamageTypes: String {
    case physical = "1"   // 物理
    case fire = "2"       // 火
    case ice = "4"        // 冰
    case lightning = "8"  // 雷
    case wind = "16"      // 风
    case quantum = "32"   // 量子
    case imaginary = "64" // 虚数

    public var damagetIcon: String {
        switch self {
        case .physical:
            return StarRailDamageIconName.physicalIcon.rawValue
        case .fire:
            return StarRailDamageIconName.fireIcon.rawValue
        case .ice:
            return StarRailDamageIconName.iceIcon.rawValue
        case .lightning:
            return StarRailDamageIconName.lightningIcon.rawValue
        case .wind:
            return StarRailDamageIconName.windIcon.rawValue
        case .quantum:
            return StarRailDamageIconName.quantumIcon.rawValue
        case .imaginary:
            return StarRailDamageIconName.imaginaryIcon.rawValue
        }
    }
}

public enum StarRailDamageIconName: String {
    case physicalIcon = "physical"    // 物理
    case fireIcon = "fire"            // 火
    case iceIcon = "ice"              // 冰
    case lightningIcon = "lightning"  // 雷
    case windIcon = "wind"            // 风
    case quantumIcon = "quantum"      // 量子
    case imaginaryIcon = "imaginary"  // 虚数
}

