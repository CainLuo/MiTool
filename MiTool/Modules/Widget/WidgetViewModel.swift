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

            fetchGameCard(uid: user.uid, server: StarRailGameBiz.china.rawValue)
            fetchGameCard(uid: user.uid, server: GenshinGameBiz.china.rawValue)

            var starRailItem = WidgetSectionItem()
            var genshinItem = WidgetSectionItem()

            dbManager.getStarRailGameCard(uuid: user.uid) { starRailInfo in
                starRailItem = WidgetSectionItem(
                    uid: starRailInfo.gameUID,
                    nickname: starRailInfo.nickname,
                    server: starRailInfo.region
                )
            }
            
            dbManager.getGenshinGameCard(uuid: user.uid) { starRailInfo in
                genshinItem = WidgetSectionItem(
                    uid: starRailInfo.gameUID,
                    nickname: starRailInfo.nickname,
                    server: starRailInfo.region
                )
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
    
    private func fetchGameCard(uid: String, server: String) {
        ApiManager.shared.fetchStarRailGameCards(
            uid: uid,
            server: StarRailGameBiz.china.rawValue
        )
            .sink { (result: MihoyoGameCardsModel) in
                guard let list = result.data?.list else {
                    return
                }
                if server == StarRailGameBiz.china.rawValue {
                    SQLManagerHelper.saveStarRailCards(uid, gameCards: list)
                }
                if server == GenshinGameBiz.china.rawValue {
                    SQLManagerHelper.saveGenshinCards(uid, gameCards: list)
                }
            }
            .store(in: &cancellables)
    }
}
