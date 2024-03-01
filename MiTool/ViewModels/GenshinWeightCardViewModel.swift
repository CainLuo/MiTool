//
//  GenshinWeightCardViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/20.
//

import SwiftUI

class GenshinWeightCardViewModel: ObservableObject {
    private let manager = MockApi.shared

    @Published var data = GenshinImpactDailyNodeData()
    @Published var recoveryTime: String = ""
    @Published var staminaColor: Color = .red
    @Published var dailyNodes: [GenshinImpactLocalDailyModel] = []

    func getGenshinWeight() {
        guard let data = manager.getGshinImpactWeight().data else {
            return
        }

        self.data = data
        let time = Int(data.resinRecoveryTime) ?? 0
        setUpRecoveryTime(staminaRecoverTime: time)
        setUpStaminaColor(staminaRecoverTime: time)
        setupDailyNode()
    }

    private func setUpRecoveryTime(staminaRecoverTime: Int) {
        if staminaRecoverTime == 0 {
            recoveryTime = CopyGenshinWeight.recoveryDone
        } else if staminaRecoverTime < 3600 {
            let minutes = staminaRecoverTime / 60
            recoveryTime = String(format: CopyGenshinWeight.transformerMinutes, minutes)
        } else {
            let minutes = staminaRecoverTime % 3600 / 60
            let hour = Int(staminaRecoverTime / 3600)
            recoveryTime = String(format: CopyGenshinWeight.transformerHour, hour, minutes)
        }
    }

    private func setUpStaminaColor(staminaRecoverTime: Int) {
        let staminaLastTime = 1 - (CGFloat(staminaRecoverTime) / 86400.0)

        if staminaLastTime > 0.3 && staminaLastTime < 0.8 {
            staminaColor = .blue
        } else if staminaLastTime > 0.8 && staminaLastTime <= 1 {
            staminaColor = .green
        } else {
            staminaColor = .red
        }
    }
    
    private func setupDailyNode() {
        dailyNodes = [
            GenshinImpactLocalDailyModel(
                iconNmae: "homeCoin",
                currentValue: data.currentHomeCoin,
                maxValue: data.maxHomeCoin
            ),
            GenshinImpactLocalDailyModel(
                iconNmae: "resinDiscount",
                currentValue: data.remainResinDiscountNum,
                maxValue: data.resinDiscountNumLimit
            ),
            GenshinImpactLocalDailyModel(
                iconNmae: "task",
                currentValue: data.finishedTaskNum,
                maxValue: data.totalTaskNum
            ),
            GenshinImpactLocalDailyModel(
                iconNmae: "transformer",
                otherContent: data.transformerTime
            )
        ]
    }
}
