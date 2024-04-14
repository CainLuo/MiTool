//
//  WidgetViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/2.
//

import SwiftUI

class WidgetViewModel: BaseViewModel {
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
            ApiManager.shared.cookieToken = user.cookieToken ?? ""
            
            dbManager.getMihoyoGames()
                .sink { games in
                    var starRailItem = WidgetSectionItem()
                    var genshinItem = WidgetSectionItem()

                    games.forEach { gameItem in
                        let isGenshin = gameItem.gameBiz.contains("hk4e")
                        let isStarRail = gameItem.gameBiz.contains("hkrpg")

                        if isGenshin {
                            genshinItem = WidgetSectionItem(
                                uid: gameItem.gameUID,
                                nickname: gameItem.nickname,
                                server: gameItem.region
                            )
                        }
                        
                        if isStarRail {
                            starRailItem = WidgetSectionItem(
                                uid: gameItem.gameUID,
                                nickname: gameItem.nickname,
                                server: gameItem.region
                            )
                        }
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
                .store(in: &cancellables)
        }
        widgetSections = sections
    }
}
