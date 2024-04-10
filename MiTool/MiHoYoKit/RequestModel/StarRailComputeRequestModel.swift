//
//  StarRailComputeRequestModel.swift
//  MiTool
//
//  Created by Cain on 2024/4/7.
//

import Foundation
import ObjectMapper

struct StarRailComputeRequestModel: Mappable {
    var uid: String?
    var region: String?
    var game: String = "hkrpg"
    var lang: String = LanguageManager.getLang()
    var avatar: StarRailComputeRequestTargetModel?
    var equipment: StarRailComputeRequestTargetModel?
    var skillList: [StarRailComputeRequestTargetModel] = []
    
    init?(map: Map) {}
    
    init(
        uid: String?,
        region: String?,
        avatar: StarRailComputeRequestTargetModel? = nil,
        equipment: StarRailComputeRequestTargetModel? = nil,
        skillList: [StarRailComputeRequestTargetModel] = []
    ) {
        self.uid = uid
        self.region = region
        self.avatar = avatar
        self.equipment = equipment
        self.skillList = skillList
    }
    
    init(role: StarRailRoleInfoData, roleRegion: String) {
        self.skillList = filterSkills(role: role)
        self.avatar = StarRailComputeRequestTargetModel(
            itemID: role.avatar?.itemID,
            curLevel: role.avatar?.curLevel ?? 1,
            targetLevel: role.avatar?.targetLevel ?? 80
        )
        
        if let eqiopment = role.equipment {
            self.equipment = StarRailComputeRequestTargetModel(
                itemID: eqiopment.itemID,
                curLevel: eqiopment.curLevel,
                targetLevel: eqiopment.targetLevel
            )
        }
    }
    
    
    private func filterSkills(role: StarRailRoleInfoData) -> [StarRailComputeRequestTargetModel] {
        var requestSkills: [StarRailComputeRequestTargetModel] = []
        var roleSkills: [StarRailRoleInfoSkill] = []
        let point1Skill = role.skills.filter { $0.anchor == .one && $0.curLevel < 6 }
        let pointSkills = role.skills.filter { $0.anchor != .one && $0.curLevel < 10 }
        
        roleSkills.append(contentsOf: point1Skill)
        roleSkills.append(contentsOf: pointSkills)
        
        if roleSkills.isNotEmpty {
            requestSkills = roleSkills.map {
                StarRailComputeRequestTargetModel(
                    itemID: $0.pointID,
                    curLevel: $0.curLevel,
                    targetLevel: $0.maxLevel ?? 1
                )
            }
        }
        
        let skillsOther = role.skillsOther.filter { $0.progress != .learned }
            .map {
                StarRailComputeRequestTargetModel(
                    itemID: $0.pointID,
                    curLevel: $0.curLevel,
                    targetLevel: $0.maxLevel ?? 1
                )
            }
        
        if skillsOther.isNotEmpty {
            requestSkills.append(contentsOf: skillsOther)
        }
        
        return requestSkills
    }
    
    mutating func mapping(map: Map) {
        game <- map["game"]
        lang <- map["lang"]
        uid <- map["uid"]
        region <- map["region"]
        avatar <- map["avatar"]
        equipment <- map["equipment"]
        skillList <- map["skill_list"]
    }
}

class StarRailComputeRequestTargetModel: Mappable {
    var itemID: String?
    var curLevel: Int = 1
    var targetLevel: Int = 80
    
    required init?(map: Map) {}
    
    init(itemID: String?, curLevel: Int = 1, targetLevel: Int = 80) {
        self.itemID = itemID
        self.curLevel = curLevel
        self.targetLevel = targetLevel
    }
    
    func mapping(map: Map) {
        itemID <- map["item_id"]
        curLevel <- map["cur_level"]
        targetLevel <- map["target_level"]
    }
}
