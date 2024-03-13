//
//  MockApi.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import SwiftUI

public class MockApi: ApiProtocol {
    public static let shared = MockApi()

//    private init() { }

    public func getMihoyoUserInfo() -> MihoyoUserModel {
        guard let model = Bundle.getJSONFile(
            "mihoyoUser",
            responseType: MihoyoUserModel.self
        ) else {
            return MihoyoUserModel()
        }
        return model
    }
    
    public func getMihoyoGameCards() -> MihoyoGameCardsModel {
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
    public func getStarRailMyRoleList() -> StarRailAllRoleModel {
        guard let model = Bundle.getJSONFile(
            "starRailAllAvatars",
            responseType: StarRailAllRoleModel.self
        ) else {
            return StarRailAllRoleModel()
        }
        return model
    }

    public func getStarRailWidget() -> StarRailWidgetModel? {
        guard let model = Bundle.getJSONFile(
            "starRailDailyNode",
            responseType: StarRailWidgetModel.self
        ) else {
            return StarRailWidgetModel()
        }
        return model
    }

    public func getRoleInfo(id: String) -> StarRailRoleInfoModel {
        guard let model = Bundle.getJSONFile(
            "\(id)Skill",
            responseType: StarRailRoleInfoModel.self) else {
            return StarRailRoleInfoModel()
        }
        return model
    }

    public func getSkillCompute(id: String) -> StarRailSkillComputeModel {
        guard let model = Bundle.getJSONFile(
            "\(id)SkillCompute",
            responseType: StarRailSkillComputeModel.self
        ) else {
            return StarRailSkillComputeModel()
        }
        return model
    }

    public func getStarRailDailyNote() -> StarRailWidgetModel {
        StarRailWidgetModel()
    }

    public func getStarRailCharacter() -> Any {
        ""
    }

    public func getStarRailAvatarList() -> Any {
        ""
    }

    public func getStarRailAvatarDetail() -> Any {
        ""
    }

    public func getStarRailEquipmentList() -> Any {
        ""
    }

    public func getSkillRogue(id: String) -> Any {
        ""
    }

    public func getSkillChallenge(id: String) -> Any {
        ""
    }
}

// MARK: - Get Genshin Impact Info
extension MockApi {
    public func getGshinImpactDailyNote() -> GenshinDailyNodeModel {
        GenshinDailyNodeModel()
    }

    public func getGshinImpactCharacter() -> GenshinCharacterModel {
        GenshinCharacterModel()
    }

    public func getGshinImpactAvatarList() -> Any {
        ""
    }

    public func getGshinImpactFilterList() -> Any {
        ""
    }

    public func getGshinImpactAvatarSkill() -> Any {
        ""
    }

    public func getGshinImpactCompute() -> Any {
        ""
    }

    public func getGshinImpactSpiralAbyss() -> Any {
        ""
    }

    public func getGshinImpactWeight() -> GenshinDailyNodeModel {
        guard let model = Bundle.getJSONFile(
            "genshinDailyNote",
            responseType: GenshinDailyNodeModel.self)
        else {
            return GenshinDailyNodeModel()
        }
        return model
    }
}