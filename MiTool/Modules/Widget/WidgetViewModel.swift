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
            ApiManager.shared.cookie = user.cookie ?? ""
            ApiManager.shared.deviceFP = user.deivceFP ?? ""
            ApiManager.shared.deviceID = user.deviceID ?? UUID().uuidString
            ApiManager.shared.sToken = user.sToken ?? ""
            ApiManager.shared.region = Region(rawValue: user.region ?? "") ?? .china
            
            var genshinItem = WidgetSectionItem()
            var starRailItem = WidgetSectionItem()

            dbManager.getStarRailGameCard(uuid: user.uid) { starRailInfo in
                starRailItem = WidgetSectionItem(
                    uid: starRailInfo.gameUID,
                    nickname: starRailInfo.nickname,
                    server: starRailInfo.region
                )
            }

            let gameCards = dbManager.getAllMihoyoGameCards(uuid: user.uid)
            
            let genshinInfo = gameCards.first { 
                $0.gameID == .genshin
            }

            if let genshinInfo = genshinInfo {
                genshinItem = WidgetSectionItem(
                    uid: genshinInfo.gameRoleID,
                    nickname: genshinInfo.nickname,
                    server: genshinInfo.region
                )
            }
            
            let starRailInfo = gameCards.first {
                $0.gameID == .starRail
            }

            sections.append(
                WidgetSectionModel(
                    uid: user.uid,
                    title: user.nickname,
                    genshinItem: genshinItem,
                    starRailItem: starRailItem
                )
            )
        }
        widgetSections = sections
    }
}
