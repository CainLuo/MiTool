//
//  Api.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import Foundation

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
    func getStarRailMyRoleList() -> StarRailAllRoleModel {
        StarRailAllRoleModel()
    }

    func getStarRailWidget() async -> StarRailWidgetModel? {
        let url = URL(string: ApiKeys.Host.mihoyo.rawValue + ApiKeys.StarRail.widget.rawValue)!
        let parameters = ["server": "prod_gf_cn",
                          "role_id": ""]
        let ds = ApiDSHelper.getDS(region: .china, query: parameters.toJSONString ?? "")
        let headers = ApiHeaderConfiguration.defaultHeaders(region: .china, additionalHeaders: ["DS": ds])
        do {
            let model: StarRailWidgetModel = try await ApiNetworkManager().performRequest(
                url: url,
                headers: headers,
                parameters: parameters
            )
            return model
        } catch {
            if let apiError = error as? ApiNetworkError {
                switch apiError {
                case .invalidData:
                    Logger.error("Invalid data error occurred.")
                case .requestFailed(let underlyingError):
                    Logger.error("Request failed with error: \(underlyingError)")
                }
            } else {
                Logger.error(error)
            }
        }
        return nil
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
    func getGshinImpactDailyNote() -> GenshinDailyNodeModel {
        GenshinDailyNodeModel()
    }

    func getGshinImpactCharacter() -> GenshinCharacterModel {
        GenshinCharacterModel()
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

    func getGshinImpactWeight() -> GenshinDailyNodeModel {
        GenshinDailyNodeModel()
    }
}
