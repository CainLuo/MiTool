//
//  MihoyoUserEditViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import Foundation

class MihoyoUserEditViewModel: BaseViewModel {
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
        ApiManager.shared.fetchDeivceFP(deviceId: UUID(), cookie: cookie)
            .sink { [weak self] (result: MiHoYoDeviceFPResponseModel) in
                guard let deviceFp = result.data?.deviceFp else {
                    return
                }
                self?.deivceFP = deviceFp
                ApiManager.shared.deviceFP = deviceFp
            }
            .store(in: &cancellables)
    }
    
    func fetchSTokenV2(cookie: String) {
        ApiManager.shared.fetchSTokenV2(cookie: cookie)
            .sink { [weak self] (result: MihoyoSTokenModel) in
                guard let sTokenV2 = result.data?.token?.token else {
                    return
                }
                self?.sTokenV2 = sTokenV2
                ApiManager.shared.sToken = sTokenV2
            }
            .store(in: &cancellables)
    }
    
    func fetchMihoyoUserInfo(
        region: String
    ) {
        let regionSever = Region.region(region)
        ApiManager.shared.fetchMihoyoUserInfo(uid: uid, region: regionSever)
            .sink { [weak self] (result: MihoyoUserModel) in
                guard let userInfo = result.data?.userInfo else {
                    return
                }
                self?.uid = userInfo.uid
                self?.nickname = userInfo.nickname
                self?.fetchGameCard(uid: userInfo.uid, server: StarRailGameBiz.china.rawValue)
                self?.fetchGameCard(uid: userInfo.uid, server: GenshinGameBiz.china.rawValue)
            }
            .store(in: &cancellables)
    }
    
    func fetchGameCard(uid: String, server: String) {
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
    
    func cookieConvertUID(cookie: String) {
        let strings = cookie.components(separatedBy: ";")
        let stuids = strings.filter { $0.contains("stuid=") }
        if let uidString = stuids.first {
            let uid = uidString.replacingOccurrences(of: "stuid=", with: "")
            self.uid = uid
        }
    }
}
