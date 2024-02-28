//
//  MockApi.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import SwiftUI

class MockApi: ApiProtocol {
    static let shared = MockApi()
    
    private init() { }

    func getMihoyoGameRecord() -> MihoyoGameRecordModel {
        guard let dataJson = Bundle.getJSONFile("mihoyoPersonal"),
              let model = MihoyoGameRecordModel(JSON: dataJson) else {
            return MihoyoGameRecordModel()
        }
        return model
    }
}

// MARK: - Get Star Rail Info
extension MockApi {
    func getStarRailAllRoleList() -> StarRailAllRoleModel {
        guard let dataJson = Bundle.getJSONFile("starRailAllAvatars"),
              let model = StarRailAllRoleModel(JSON: dataJson) else {
            return StarRailAllRoleModel()
        }
        return model
    }
        
    func getStarRailWeight() -> StarRailWeightModel {
        guard let dataJson = Bundle.getJSONFile("starRailDailyNode"),
              let model = StarRailWeightModel(JSON: dataJson) else {
            return StarRailWeightModel()
        }
        return model
    }
    
    func getRoleInfo(id: String) -> StarRailRoleInfoModel {
        guard let dataJson = Bundle.getJSONFile("\(id)Skil"),
              let model = StarRailRoleInfoModel(JSON: dataJson) else {
            return StarRailRoleInfoModel()
        }
        return model
    }
    
    func getSkillCompute(id: String) -> StarRailSkillComputeModel {
        guard let dataJson = Bundle.getJSONFile("\(id)SkillCompute"),
              let model = StarRailSkillComputeModel(JSON: dataJson) else {
            return StarRailSkillComputeModel()
        }
        return model
    }
    
    func getStarRailDailyNote() -> StarRailWeightModel {
        StarRailWeightModel()
    }
    
    func getStarRailCharacter() -> Any {
        ""
    }
    
    func getStarRailAvatarList() -> Any {
        ""
    }
    
    func getStarRailAvatarDetail() -> Any {
        ""
    }
    
    func getStarRailEquipmentList() -> Any {
        ""
    }
    
    func getSkillRogue(id: String) -> Any {
        ""
    }
    
    func getSkillChallenge(id: String) -> Any {
        ""
    }
}

// MARK: - Get Genshin Impact Info
extension MockApi {
    func getGshinImpactDailyNote() -> GenshinImpactDailyNodeModel {
        GenshinImpactDailyNodeModel()
    }
    
    func getGshinImpactCharacter() -> GenshinImpactCharacterModel {
        GenshinImpactCharacterModel()
    }
    
    func getGshinImpactAvatarList() -> Any {
        ""
    }
    
    func getGshinImpactFilterList() -> Any {
        ""
    }
    
    func getGshinImpactAvatarSkill() -> Any {
        ""
    }
    
    func getGshinImpactCompute() -> Any {
        ""
    }
    
    func getGshinImpactSpiralAbyss() -> Any {
        ""
    }

    func getGshinImpactWeight() -> GenshinImpactDailyNodeModel {
        guard let dataJson = Bundle.getJSONFile("genshinDailyNote"),
              let model = GenshinImpactDailyNodeModel(JSON: dataJson) else {
            return GenshinImpactDailyNodeModel()
        }
        return model
    }
}
