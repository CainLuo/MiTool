//
//  MihoyoUserEditViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import Foundation
import Combine

class MihoyoUserEditViewModel: BaseViewModel {
    @Published var saveUserSuccess = false
    @Published var saveUserFailed = false
    @Published var uid: String = ""
    @Published var nickname: String = ""
    @Published var deivceFP: String = ""
    @Published var sTokenV2: String = ""
    @Published var cookie: String = ""
    @Published var cookieToken: String = ""

    func getUserInfo(uid: String) {
        SQLManagerHelper.getMihoyoUser(uid: uid) { [weak self] userInfo in
            self?.uid = userInfo.uid
            self?.nickname = userInfo.nickname
            self?.deivceFP = userInfo.deivceFP ?? ""
            self?.sTokenV2 = userInfo.sToken ?? ""
            self?.cookie = userInfo.cookie ?? ""
        }
    }

    func getMihoyoAuth(with cookie: String) {
        cookieConvertUID(cookie: cookie)

        fetchDeivceFP(cookie: cookie)
        fetchSTokenV2(cookie: cookie)
        fetchCookieToken(cookie: cookie)
    }
    
    func saveMihoyoUser(
        region: String
    ) {
        let regionSever = AccountRegion.region(region)
        let userInfo = MihoyoUserInfo(
            uid: uid,
            nickname: nickname,
            cookie: cookie,
            sToken: sTokenV2,
            deivceFP: deivceFP,
            deviceID: UUID().uuidString,
            region: regionSever.rawValue,
            cookieToken: cookieToken
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
    
    func fetchMihoyoUserInfo(
        region: String
    ) {
        let regionSever = AccountRegion.region(region)
        ApiManager.shared.fetchMihoyoUserInfo(uid: uid, region: regionSever)
            .sink { [weak self] (result: MihoyoUserModel) in
                guard let userInfo = result.data?.userInfo else {
                    return
                }
                self?.uid = userInfo.uid
                self?.nickname = userInfo.nickname
                self?.fetchGameCard(uid: userInfo.uid)
            }
            .store(in: &cancellables)
    }
    
    func fetchGameCard(uid: String) {
        let games = [StarRailGameBiz.china.rawValue, GenshinGameBiz.china.rawValue]
        
        Publishers.Sequence(sequence: games)
            .flatMap { server in
                ApiManager.shared.fetchStarRailGameCards(
                    uid: uid,
                    server: server)
                .map { (server, $0) }
            }
            .collect()
            .sink { _ in
                Logger.info("success")
            } receiveValue: { (result: [(String, MihoyoGamesModel)]) in
                result.forEach { gameCards in
                    guard let list = gameCards.1.data?.list else {
                        return
                    }
                    SQLManagerHelper().saveMihoyoGames(uid, gameCards: list)
                }
            }
            .store(in: &cancellables)
    }
    
    private func cookieConvertUID(cookie: String) {
        let strings = cookie.components(separatedBy: ";")
        let stuids = strings.filter { $0.contains("stuid=") }
        if let uidString = stuids.first {
            let uid = uidString.replacingOccurrences(of: "stuid=", with: "")
            self.uid = uid
        }
    }
}

extension MihoyoUserEditViewModel {
    private func fetchDeivceFP(cookie: String) {
        ApiManager.shared.cookie = cookie
        ApiManager.shared.fetchDeivceFP(deviceId: UUID(), cookie: cookie)
            .sink { [weak self] (result: MihoyoDeviceFPResponseModel) in
                guard let deviceFp = result.data?.deviceFp else {
                    return
                }
                self?.deivceFP = deviceFp
                ApiManager.shared.deviceFP = deviceFp
            }
            .store(in: &cancellables)
    }
    
    private func fetchSTokenV2(cookie: String) {
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

    private func fetchCookieToken(cookie: String) {
        ApiManager.shared.fetchCookieToken(cookie: cookie)
            .sink { [weak self] (result: MihoyoCookieTokenModel) in
                guard let cookieToken = result.data?.cookieToken else {
                    return
                }
                self?.cookieToken = cookieToken
                ApiManager.shared.cookieToken = cookieToken
            }
            .store(in: &cancellables)
    }
}
