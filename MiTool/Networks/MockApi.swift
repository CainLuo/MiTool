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

//    private init() { }

    func getMihoyoUserInfo() -> MihoyoUserModel {
        guard let model = Bundle.getJSONFile(
            "mihoyoUser",
            responseType: MihoyoUserModel.self
        ) else {
            return MihoyoUserModel()
        }
        return model
    }
    
    func getMihoyoGameCards() -> MihoyoGameCardsModel {
        guard let model = Bundle.getJSONFile(
            "mihoyoPersonal",
            responseType: MihoyoGameCardsModel.self
        ) else {
            return MihoyoGameCardsModel()
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

    func getStarRailWidget() -> StarRailWidgetModel {
        guard let model = Bundle.getJSONFile(
            "starRailDailyNode",
            responseType: StarRailWidgetModel.self
        ) else {
            return StarRailWidgetModel()
        }
        return model
    }

    func getRoleInfo(id: String) -> StarRailRoleInfoModel {
        guard let model = Bundle.getJSONFile(
            "\(id)Skill",
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

    func getStarRailDailyNote() -> StarRailWidgetModel {
        StarRailWidgetModel()
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
