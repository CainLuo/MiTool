//
//  MihoyoUserEditViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import AppKit
import SwiftUI

class MihoyoUserEditViewModel: ObservableObject {
    @Published var saveUserSuccess = false
    @Published var saveUserFailed = false
    @Published var uid: String = ""
    @Published var nickname: String = ""
    @Published var deivceFP: String = ""
    @Published var sTokenV2: String = ""
    @Published var cookie: String = ""

    func getUserInfo(uid: String) {
        SQLManagerHelper.getMihoyoUser(uid: uid) { [weak self] userInfo in
            self?.uid = userInfo.uid
            self?.nickname = userInfo.nickname
            self?.deivceFP = userInfo.deivceFP ?? ""
            self?.sTokenV2 = userInfo.sToken ?? ""
            self?.cookie = userInfo.cookie ?? ""
        }
    }

    func saveMihoyoUser(
        region: String
    ) {
        let regionSever = Region.region(region)
        let userInfo = MihoyoUserInfo(
            uid: uid,
            nickname: nickname,
            cookie: cookie,
            sToken: sTokenV2,
            deivceFP: deivceFP,
            deviceID: UUID().uuidString,
            region: regionSever.rawValue
        )

        ApiManager.shared.deviceID = userInfo.deviceID ?? UUID().uuidString
        ApiManager.shared.region = regionSever

        SQLManagerHelper.saveMihoyoUser(userInfo: userInfo) { [weak self] _, error in
            guard error == nil else {
                self?.saveUserFailed = true
                return
            }
            self?.saveUserSuccess = true
        }
    }
    
    func fetchDeivceFP(cookie: String) {
        ApiManager.shared.cookie = cookie
        ApiManager.shared.fetchDeivceFP(deviceId: UUID(), cookie: cookie) { [weak self] deivceFP in
            guard !deivceFP.isEmpty else {
                return
            }
            self?.deivceFP = deivceFP
            ApiManager.shared.deviceFP = deivceFP
        }
    }
    
    func fetchSTokenV2(cookie: String) {
        ApiManager.shared.fetchSTokenV2(cookie: cookie) { [weak self] sTokenV2 in
            guard !sTokenV2.isEmpty else {
                return
            }
            self?.sTokenV2 = sTokenV2
            ApiManager.shared.sToken = sTokenV2
        }
    }
    
    func fetchMihoyoUserInfo(
        region: String
    ) {
        let regionSever = Region.region(region)
        ApiManager.shared.fetchMihoyoUserInfo(uid: uid, region: regionSever) { [weak self] result in
            self?.uid = result.uid
            self?.nickname = result.nickname
            self?.fetchGameCard()
        }
    }
    
    func fetchGameCard() {
        ApiManager.shared.fetchStarRailGameCards(uid: uid, server: StarRailGameBiz.china.rawValue)
    }
    
    func cookieConvertUID(cookie: String) {
        let strings = cookie.components(separatedBy: ";")
        let stuids = strings.filter { $0.contains("stuid=") }
        if let uidString = stuids.first {
            let uid = uidString.replacingOccurrences(of: "stuid=", with: "")
            self.uid = uid
        }
    }
}
