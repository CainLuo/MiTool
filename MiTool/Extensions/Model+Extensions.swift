//
//  Model+Extensions.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation

extension GenshinCharacterAvatar {
    public var avatarURL: String {
        icon ?? ""
    }
    
    public var constellation: String {
        guard let activedConstellationNum else {
            return ""
        }
        return CopyGenshinWidget.constellation + "\(activedConstellationNum)"
    }
    
    public var levelContent: String {
        "Lv.\(level)"
    }
}

extension GenshinCharacterReliquary {
    public var iconURL: String {
        icon ?? ""
    }
    
    public var levelString: String {
        "Lv: \(level ?? 1)"
    }
}

extension GenshinCharacterWeapon {
    public var weaponURL: String {
        icon ?? ""
    }
    
    public var affixContent: String {
        guard let affixLevel else {
            return ""
        }
        return CopyGenshinWidget.affix + "\(affixLevel)"
    }
    
    public var levelContent: String {
        "Lv.\(level)"
    }
}

extension GenshinDailyNodeData {
    public var resinContent: String {
        "\(currentResin)/\(maxResin)"
    }

    public var transformerTime: String {
        guard let recoveryTime = transformer?.recoveryTime else {
            return ""
        }

        if recoveryTime.reached {
            return CopyGenshinWidget.ready
        } else {
            if recoveryTime.day > 0 {
                return String(format: CopyGenshinWidget.transformerDay, recoveryTime.day, recoveryTime.hour)
            } else {
                return String(format: CopyGenshinWidget.transformerHour, recoveryTime.hour, recoveryTime.minute)
            }
        }
    }
}

extension GenshinDailyNodeExpedition {
    public var remainedTimeString: String {
        guard let remainedTime = Int(remainedTime) else {
            return ""
        }

        let tempMinute = remainedTime % 3600
        let minute = tempMinute / 60
        let hour = (remainedTime - tempMinute) / 3600
        return String(format: CopyGenshinWidget.transformerHour, hour, minute)
    }

    public var timeProgress: CGFloat {
        guard let remainedTime = Int(remainedTime) else {
            return 0
        }
        if remainedTime == 0 {
            return 1
        } else {
            return (3600.0 / CGFloat(remainedTime))
        }
    }
}

// MARK:
public struct GenshinLocalDailyModel: Identifiable {
    public var id = UUID()
    public var iconNmae: String
    public var currentValue: Int = 0
    public var maxValue: Int = 0
    public var valueContent: String {
        "\(currentValue)/\(maxValue)"
    }
    public var otherContent: String? = nil
}

extension GenshinRoleSkillItemModel {
    public var level: String {
        "Lv: \(currentLevel)"
    }
    
    public var skillURL: String {
        icon ?? ""
    }
}

extension GenshinRoleReliquaryModel {
    public var levelString: String {
        "Lv: \(currentLevel)"
    }
}

extension GenshinWidgetData {
    public var resinContent: String {
        "\(currentResin)/\(maxResin)"
    }
}

extension GenshinWeaponItemModel {
    public var iconURL: String {
        icon ?? ""
    }
    
    public var nameContent: String {
        name ?? ""
    }
    
    public var levelContent: String {
        guard let maxLevel else {
            return "Lv: 1/90"
        }
        return "Lv: 1/\(maxLevel)"
    }
}

extension StarRailAllRoleListModel {
    public var level: String {
        "Lv: \(curLevel) / \(maxLevel)"
    }
}

extension StarRailRoleInfoAvatar {
    var level: String {
        "Lv.\(curLevel)"
    }
}

extension StarRailRoleInfoEquipment {
    var levelString: String {
        "Lv.\(curLevel)/\(maxLevel)"
    }
}

extension StarRailRoleInfoSkill {
    var skillLevel: String {
        guard let maxLevel = maxLevel else {
            return "Lv.1/-"
        }
        return "Lv.\(curLevel)/\(maxLevel)"
    }
}

extension StarRailWidgetExpeditionModel {
    public var timeString: String {
        if remainingTime == 0 {
            return CopyStarRailWidget.finished
        } else if remainingTime < 3600 {
            let minutes = remainingTime / 60
            return String(format: CopyGenshinWidget.transformerMinutes, minutes)
        } else {
            let minutes = remainingTime % 3600 / 60
            let hour = Int(remainingTime / 3600)
            return String(format: CopyGenshinWidget.transformerHour, hour, minutes)
        }
    }
    
    public var timeProgress: CGFloat {
        if remainingTime == 0 {
            return 1
        } else {
            return (3600.0 / CGFloat(remainingTime))
        }
    }
}

public enum StarRailLocalType {
    case daily
    case weekly
    case entrusted
    case weeklyMonster
}

public struct StarRailLocalModel: Identifiable, Hashable {
    public var id = UUID()
    public var type: StarRailLocalType
    public var currentValue: Int = 0
    public var maxValue: Int = 0
    
    public var name: String {
        switch type {
        case .daily:
            return CopyStarRailWidget.daily
        case .weekly:
            return CopyStarRailWidget.weekly
        case .entrusted:
            return CopyStarRailWidget.entrusted
        case .weeklyMonster:
            return CopyStarRailWidget.weeklyMonster
        }
    }
}
