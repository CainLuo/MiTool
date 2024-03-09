//
//  WidgetViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/2.
//

import SwiftUI

class WidgetViewModel: ObservableObject {
    @Published var widgetSections: [WidgetSectionModel] = []
    
    private let dbManager = SQLManager.shared
    
    func getWidgetSections() {
        let userList = dbManager.getMihoyoUserList()
        var sections: [WidgetSectionModel] = []
        
        for user in userList {
            let gameCards = dbManager.getAllMihoyoGameCards(uuid: user.uid)
            
            let genshinID = gameCards.first {
                $0.gameID == .genshin
            }?.gameRoleID ?? ""

            let starRailID = gameCards.first {
                $0.gameID == .starRail
            }?.gameRoleID ?? ""

            sections.append(
                WidgetSectionModel(
                    uid: user.uid,
                    title: user.nickname,
                    genshinUID: genshinID,
                    starRailUID: starRailID
                )
            )
        }
        widgetSections = sections
    }
}
