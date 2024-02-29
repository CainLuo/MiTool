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
        guard let model = Bundle.getJSONFile(
            "mihoyoPersonal",
            responseType: MihoyoGameRecordModel.self
        ) else {
            return MihoyoGameRecordModel()
        }
        return model
    }
}

// MARK: - Get Star Rail Info
extension MockApi {
    func getStarRailAllRoleList() -> StarRailAllRoleModel {
        guard let model = Bundle.getJSONFile(
            "starRailAllAvatars",
            responseType: StarRailAllRoleModel.self
        ) else {
            return StarRailAllRoleModel()
        }
        return model
    }

    func getStarRailWeight() -> StarRailWeightModel {
        guard let model = Bundle.getJSONFile(
            "starRailDailyNode",
            responseType: StarRailWeightModel.self
        ) else {
            return StarRailWeightModel()
        }
        return model
    }

    func getRoleInfo(id: String) -> StarRailRoleInfoModel {
        guard let model = Bundle.getJSONFile(
            "\(id)Skil",
            responseType: StarRailRoleInfoModel.self) else {
            return StarRailRoleInfoModel()
        }
        return model
    }

    func getSkillCompute(id: String) -> StarRailSkillComputeModel {
        guard let model = Bundle.getJSONFile(
            "\(id)SkillCompute",
            responseType: StarRailSkillComputeModel.self
        ) else {
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
        guard let model = Bundle.getJSONFile(
            "genshinDailyNote",
            responseType: GenshinImpactDailyNodeModel.self)
        else {
            return GenshinImpactDailyNodeModel()
        }
        return model
    }
}
