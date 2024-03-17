//
//  StarRailWidgetCardViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/16.
//

import SwiftUI

class StarRailWidgetCardViewModel: ObservableObject {
    /// 0~0.3 is Color.red
    /// 0.3~0.8 is Color.blue
    /// 0.8~1 is Color.green
    @Published var staminaColor: Color = .red
    @Published var stamina: String = "0/0"
    @Published var staminaLastTime: CGFloat = 0
    @Published var expeditions: [StarRailWidgetExpeditionModel] = []
    @Published var localModels: [StarRailLocalModel] = []
    @Published var recoveryTime: String = ""
    @Published var reserveStamina: String = ""
    @Published var reserveStaminaFull: String = ""

    func fetchStarRailWidget(item: WidgetSectionItem) {
        ApiManager.shared.fetchStarRailWidget(uid: item.uid) { [weak self] data in
            self?.expeditions = data.expeditions ?? []
            self?.stamina = "\(data.currentStamina)/\(data.maxStamina)"
            self?.reserveStamina = "\(data.currentReserveStamina)"
            
            let tipsString = "\(data.isReserveStaminaFull ? CopyStarRailWidget.fullYes : CopyStarRailWidget.fullNo)"
            self?.reserveStaminaFull = CopyStarRailWidget.reserveTrailblazePowerFull + tipsString
            
            self?.setUpStaminaColor(staminaRecoverTime: data.staminaRecoverTime)
            self?.setUpLocalModels(data: data)
        }
    }
    
    private func setUpStaminaColor(staminaRecoverTime: Int) {
        setUpRecoveryTime(staminaRecoverTime: staminaRecoverTime)
        let staminaLastTime = 1 - (CGFloat(staminaRecoverTime) / 86400.0)
        self.staminaLastTime = staminaLastTime

        if staminaLastTime > 0.3 && staminaLastTime < 0.8 {
            staminaColor = .blue
        } else if staminaLastTime > 0.8 && staminaLastTime <= 1 {
            staminaColor = .green
        } else {
            staminaColor = .red
        }
    }
    
    private func setUpLocalModels(data: StarRailWidgetDataModel) {
        localModels = [
            StarRailLocalModel(
                type: .daily,
                currentValue: data.currentTrainScore,
                maxValue: data.maxTrainScore
            ),
            StarRailLocalModel(
                type: .weekly,
                currentValue: data.currentRogueScore,
                maxValue: data.maxRogueScore
            ),
            StarRailLocalModel(
                type: .entrusted,
                currentValue: data.acceptedEpeditionNum,
                maxValue: data.totalExpeditionNum
            )// ,
//            StarRailLocalModel(
//                type: .weeklyMonster,
//                currentValue: data.weeklyCocoonCnt,
//                maxValue: data.weeklyCocoonLimit
//            )
        ]
    }
    
    private func setUpRecoveryTime(staminaRecoverTime: Int) {
        if staminaRecoverTime == 0 {
            recoveryTime = CopyGenshinWidget.recoveryDone
        } else if staminaRecoverTime < 3600 {
            let minutes = staminaRecoverTime / 60
            recoveryTime = String(format: CopyGenshinWidget.transformerMinutes, minutes)
        } else {
            let minutes = staminaRecoverTime % 3600 / 60
            let hour = Int(staminaRecoverTime / 3600)
            recoveryTime = String(format: CopyGenshinWidget.transformerHour, hour, minutes)
        }
    }
}
