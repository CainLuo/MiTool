//
//  StarRailDamageKeys.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import Foundation

public enum Damage: String {
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
            return DamageIcon.physicalIcon.rawValue
        case .fire:
            return DamageIcon.fireIcon.rawValue
        case .ice:
            return DamageIcon.iceIcon.rawValue
        case .lightning:
            return DamageIcon.lightningIcon.rawValue
        case .wind:
            return DamageIcon.windIcon.rawValue
        case .quantum:
            return DamageIcon.quantumIcon.rawValue
        case .imaginary:
            return DamageIcon.imaginaryIcon.rawValue
        }
    }
}

public enum DamageIcon: String {
    case physicalIcon = "physical"    // 物理
    case fireIcon = "fire"            // 火
    case iceIcon = "ice"              // 冰
    case lightningIcon = "lightning"  // 雷
    case windIcon = "wind"            // 风
    case quantumIcon = "quantum"      // 量子
    case imaginaryIcon = "imaginary"  // 虚数
}

