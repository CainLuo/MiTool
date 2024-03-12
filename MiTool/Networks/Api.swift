//
//  Api.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation
import Alamofire

class Api: ApiProtocol {
    func getMihoyoUserInfo() -> MihoyoUserModel {
        MihoyoUserModel()
    }
    
    func getMihoyoGameCards() -> MihoyoGameCardsModel {
        MihoyoGameCardsModel()
    }
}

// MARK: - Get Star Rail Info
extension Api {
    func getStarRailAllRoleList() -> StarRailAllRoleModel {
        StarRailAllRoleModel()
    }

    func getStarRailWidget() -> StarRailWidgetModel {
        StarRailWidgetModel()
    }

    func getRoleInfo(id: String) -> StarRailRoleInfoModel {
        StarRailRoleInfoModel()
    }

    func getSkillCompute(id: String) -> StarRailSkillComputeModel {
        StarRailSkillComputeModel()
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
extension Api {
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
        GenshinImpactDailyNodeModel()
    }
}
