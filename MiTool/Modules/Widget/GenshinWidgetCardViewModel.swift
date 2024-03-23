//
//  GenshinWidgetCardViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/20.
//

import SwiftUI

class GenshinWidgetCardViewModel: BaseViewModel {
    @Published var data = GenshinWidgetData()
    @Published var recoveryTime: String = ""
    @Published var staminaColor: Color = .red
    @Published var dailyNodes: [GenshinLocalDailyModel] = []

    func getGenshinWidget(item: WidgetSectionItem) {
        ApiManager.shared.fetchGenshinWidget(uid: item.uid)
            .sink { [weak self] (result: GenshinWidgetModel) in
                guard let data = result.data else {
                    return
                }
                self?.data = data
                let time = Int(data.resinRecoveryTime) ?? 0
                self?.setUpRecoveryTime(staminaRecoverTime: time)
                self?.setUpStaminaColor(staminaRecoverTime: time)
                self?.setupDailyNode()
            }
            .store(in: &cancellables)
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
            GenshinLocalDailyModel(
                iconNmae: "homeCoin",
                currentValue: data.currentHomeCoin,
                maxValue: data.maxHomeCoin
            ),
            GenshinLocalDailyModel(
                iconNmae: "task",
                currentValue: data.finishedTaskNum,
                maxValue: data.totalTaskNum
            )
        ]
    }
}
