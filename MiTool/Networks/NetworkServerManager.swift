//
//  NetworkServerManager.swift
//  MiTool
//
//  Created by Cain on 2024/3/5.
//

import Foundation

class NetworkServerManager {
    private static func api() -> ApiProtocol {
        #if DEBUG
        return MockApi()
        #else
        return Api()
        #endif
    }
    
    static func fetchMihoyoUserInfo() {
        let userInfo = api().getMihoyoUserInfo()
        
    }
    
    static func fetchMihoyoGameCards(uid: String) {
        let gameCards = api().getMihoyoGameCards()
    }
}
