//
//  NetworkServerManager.swift
//  MiTool
//
//  Created by Cain on 2024/3/5.
//

import Foundation

class NetworkServerManager {
    static func api() -> ApiProtocol {
        #if DEBUG
        return MockApi()
        #else
        return Api()
        #endif
    }
    
    static func fetchMihoyoUserInfo(
        uid: String,
        completion: ((MihoyoUserInfo, [MihoyoGameCardsList]?) -> Void)?
    ) {
        let sql = SQLManager.shared
        sql.getMihoyoUser(uid) { _, userInfo in
            if let userInfo = userInfo {
                completion?(userInfo, sql.getAllMihoyoGameCards(uuid: uid))
            }
        }

        let fetchModel = api().getMihoyoUserInfo()
        guard let userInfo = fetchModel.data?.userInfo else {
            return
        }
        
        completion?(userInfo, nil)
        saveMihoyoUserInfo(userInfo) { _, _ in }
        
        fetchMihoyoGameCards(uid: uid) { list in
            completion?(userInfo, list)
        }
        
        fetchStarRailRoles(uid: uid) { _, _ in }
    }
    
    static func fetchMihoyoGameCards(
        uid: String,
        completion: (([MihoyoGameCardsList]) -> Void)?
    ) {
        let fetchModel = api().getMihoyoGameCards()
        
        guard let gameCards = fetchModel.data?.list else {
            return
        }
        
        saveMihoyoGameCards(
            uid,
            gameCards: gameCards
        ) { _, _ in
            completion?(gameCards)
        }
    }
}
