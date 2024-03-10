//
//  ApiManager+SQL.swift
//  MiTool
//
//  Created by Cain on 2024/3/5.
//

import Foundation

extension ApiManager {
    static func saveMihoyoUserInfo(
        _ userInfo: MihoyoUserInfo,
        completion: ((Bool, Error?) -> Void)?
    ) {
        let userList = SQLManager.shared.getMihoyoUserList()
        
        if userList.isEmpty {
            SQLManager.shared.addMihoyoUser(
                userInfo,
                complete: completion
            )
        } else {
            SQLManager.shared.upgradeMihoyoUser(
                userInfo.uid ,
                model: userInfo,
                complete: completion
            )
        }
        
        fetchStarRailRoles(uid: userInfo.uid) { _, _ in }
    }
    
    static func saveMihoyoGameCards(
        _ uid: String,
        gameCards: [MihoyoGameCardsList],
        completion: ((Bool, Error?) -> Void)?
    ) {
        let gameCards = SQLManager.shared.getAllMihoyoGameCards(uuid: uid)
        
        if gameCards.isEmpty {
            SQLManager.shared.addMihoyoGameCards(
                uuid: uid,
                model: gameCards,
                complete: completion
            )
        } else {
            SQLManager.shared.upgradeMihoyoGameCards(
                uuid: uid, 
                model: gameCards,
                complete: completion
            )
        }
    }
}
