//
//  EnumKeys.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/25.
//

import SwiftUI
import Foundation

enum Damage: String {
    case physical = "1"   // 物理
    case fire = "2"       // 火
    case ice = "4"        // 冰
    case lightning = "8"  // 雷
    case wind = "16"      // 风
    case quantum = "32"   // 量子
    case imaginary = "64" // 虚数
    
    var damagetIcon: String {
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
enum DamageIcon: String {
    case physicalIcon = "physical"    // 物理
    case fireIcon = "fire"            // 火
    case iceIcon = "ice"              // 冰
    case lightningIcon = "lightning"  // 雷
    case windIcon = "wind"            // 风
    case quantumIcon = "quantum"      // 量子
    case imaginaryIcon = "imaginary"  // 虚数
}

enum Destiny: String {
    case destruction = "1"     // 毁灭
    case theHunt = "2"         // 巡猎
    case erudition = "3"       // 智识
    case harmony = "4"         // 同谐
    case nihility = "5"        // 虚无
    case preservation = "6"    // 存护
    case abundance = "7"       // 丰饶
    
    var destinyIcon: String {
        switch self {
        case .destruction:
            return DestinyIcon.destructionIcon.rawValue
        case .theHunt:
            return DestinyIcon.theHuntIcon.rawValue
        case .erudition:
            return DestinyIcon.eruditionIcon.rawValue
        case .harmony:
            return DestinyIcon.harmonyIcon.rawValue
        case .nihility:
            return DestinyIcon.nihilityIcon.rawValue
        case .preservation:
            return DestinyIcon.preservationIcon.rawValue
        case .abundance:
            return DestinyIcon.abundanceIcon.rawValue
        }
    }
}

enum DestinyIcon: String {
    case destructionIcon = "destruction"      // 毁灭
    case theHuntIcon = "theHunt"              // 巡猎
    case eruditionIcon = "erudition"          // 智识
    case harmonyIcon = "harmony"              // 同谐
    case nihilityIcon = "nihility"            // 虚无
    case preservationIcon = "preservation"    // 存护
    case abundanceIcon = "abundance"          // 丰饶
}

enum RarityType: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    
    var ratityColor: Gradient {
        switch self {
        case .one:
            return Gradient(colors: [Color(hexadecimal6: 0x484B59),
                                     Color(hexadecimal6: 0x7F8088)])
        case .two:
            return Gradient(colors: [Color(hexadecimal6: 0x394C65),
                                     Color(hexadecimal6: 0x418082)])
        case .three:
            return Gradient(colors: [Color(hexadecimal6: 0x3D4371),
                                     Color(hexadecimal6: 0x4575B4)])
        case .four:
            return Gradient(colors: [Color(hexadecimal6: 0x404066),
                                     Color(hexadecimal6: 0x9864CE)])
        case .five:
            return Gradient(colors: [Color(hexadecimal6: 0x925C52),
                                     Color(hexadecimal6: 0xC6A470)])
        }
    }
    
    var ratityImage: String {
        "starRailRarity\(self.rawValue)"
    }
}
