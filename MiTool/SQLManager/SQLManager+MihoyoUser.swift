//
//  SQLManager+MihoyoUser.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import Foundation
import SQLite

fileprivate let index = Expression<Int64>("index")              // 索引
fileprivate let uid = Expression<String?>("uid")                // 米游社uid
fileprivate let cookie = Expression<String?>("cookie")          // 米游社Cookie
fileprivate let nickname = Expression<String?>("nickname")      // 昵称
fileprivate let createTime = Expression<Int?>("createTime")     // 创建时间
fileprivate let introduce = Expression<String?>("introduce")    // 简介
fileprivate let gender = Expression<Int?>("gender")             // 性别，0：保密，1：男，2：女
fileprivate let avatarURL = Expression<String?>("avatarURL")    // 头像链接
fileprivate let ipRegion = Expression<String?>("ipRegion")      // 头像链接
fileprivate let gameCard = Expression<String?>("gameCard")      // 游戏卡片，原神id：1，星穹铁道id：6

extension SQLManager {
    
    /// 创建MihoyoUser表
    /// - Parameter db: Connection
    func createMihoyoGameCardTable(_ db: Connection) {
        do {
            try db.run(mihoyoUser.create(ifNotExists: true) { t in
                t.column(index, primaryKey: .autoincrement)
                t.column(uid, unique: true)
                t.column(cookie)
                t.column(nickname)
                t.column(createTime)
                t.column(introduce)
                t.column(gender)
                t.column(avatarURL)
                t.column(ipRegion)
                t.column(gameCard)
            })
        } catch {
            #if DEBUG
            print(error)
            #endif
        }
    }
    
    /// 添加米游社用户信息
    /// - Parameters:
    ///   - mode: MihoyoUserInfo
    ///   - complete: ((Bool, Error?) -> Void)
    func addMihoyoUser(_ model: MihoyoUserInfo, complete: ((Bool, Error?) -> Void)?) {
        do {
            let insert = mihoyoUser.insert(
                uid <- model.uid,
                nickname <- model.nickname,
                cookie <- model.cookie,
                createTime <- model.communityInfo?.createdAt,
                introduce <- model.introduce,
                gender <- model.gender,
                avatarURL <- model.avatarURL,
                ipRegion <- model.ipRegion
            )
            try db.run(insert)
            complete?(true, nil)
        } catch {
            complete?(false, error)
        }
    }
    
    /// 删除所有Mihoyo的用户信息
    func removeMihoyoUsers() {
        do {
            if try db.run(mihoyoUser.delete()) > 0 {
                print("删除所有用户成功")
            } else {
                print("没有找对应的用户")
            }
        } catch {
            #if DEBUG
            print(error)
            #endif
        }
    }
    
    /// 删除指定账号的信息
    /// - Parameters:
    ///   - uuid: String
    ///   - complete: ((Bool, Error?) -> Void)
    func removeMihoyoUser(_ uuid: String, complete: ((Bool, Error?) -> Void)) {
        let mihoyoUser = mihoyoUser.filter(uid == uuid)
        do {
            if try db.run(mihoyoUser.delete()) > 0 {
                print("删除用户成功")
                complete(true, nil)
            } else {
                complete(false, nil)
            }
        } catch {
            complete(false, error)
            #if DEBUG
            print(error)
            #endif
        }
    }
    
    /// 更新账号信息
    /// - Parameters:
    ///   - model: EnkaModel
    ///   - complete: ((Bool, Error?) -> Void)
    func upgradeMihoyoAccount(_ model: MihoyoUserInfo,
                              mihoyoCookie: String,
                              complete: ((Bool, Error?) -> Void)?) {
        do {
            try db.transaction {
                let mihoyoUser = mihoyoUser.filter(uid == model.uid)
                try db.run(mihoyoUser.update(
                    uid <- model.uid,
                    nickname <- model.nickname,
                    createTime <- model.communityInfo?.createdAt,
                    introduce <- model.introduce,
                    gender <- model.gender,
                    avatarURL <- model.avatarURL,
                    ipRegion <- model.ipRegion,
                    cookie <- mihoyoCookie
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }
    
    /// 更新账号Cookie
    /// - Parameters:
    ///   - model: EnkaModel
    ///   - complete: ((Bool, Error?) -> Void)
    func upgradeMihoyoUserCookie(_ uuid: String,
                                 mihoyoCookie: String,
                                 complete: ((Bool, Error?) -> Void)?) {
        do {
            try db.transaction {
                let mihoyoUser = mihoyoUser.filter(uid == uuid)
                try db.run(mihoyoUser.update(
                    cookie <- mihoyoCookie
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }
    
    /// 更新账号Game Card JSON
    /// - Parameters:
    ///   - model: EnkaModel
    ///   - complete: ((Bool, Error?) -> Void)
    func upgradeMihoyoUserGameCard(_ uuid: String,
                                   gameCardJSON: String,
                                   complete: ((Bool, Error?) -> Void)?) {
        do {
            try db.transaction {
                let mihoyoUser = mihoyoUser.filter(uid == uuid)
                try db.run(mihoyoUser.update(
                    gameCard <- gameCardJSON
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }
    
    /// 获取所有账号列表
    /// - Parameter complete: ((_ models: [MihoyoUserListModel]) -> Void)
    func getMihoyoUserList() -> [MihoyoUserListModel] {
        var list: [MihoyoUserListModel] = []
        do {
            try db.transaction {
                try db.prepare(mihoyoUser).forEach({ item in
                    let account = MihoyoUserListModel(
                        uid: item[uid] ?? "",
                        nickname: item[nickname] ?? "",
                        introduce: item[introduce] ?? "",
                        gender: item[gender] ?? 1,
                        createdAt: item[createTime] ?? 0,
                        avatarURL: item[avatarURL] ?? "",
                        ipRegion: item[ipRegion] ?? "",
                        cookie: item[cookie] ?? ""
                    )
                    list.append(account)
                })
            }
            return list
        } catch {
            #if DEBUG
            print(error)
            #endif
            return list
        }
    }
    
    /// 获取Acount
    /// - Parameters:
    ///   - uuid: String
    ///   - complete: ((_ model: EnkaModel) -> Void)
    func getMihoyoUser(_ uuid: String, complete: ((_ model: MihoyoUserListModel) -> Void)?) {
        let query = mihoyoUser.filter(uid == uuid)
        do {
            try db.prepare(query).forEach({ item in
                complete?(MihoyoUserListModel(
                    uid: item[uid] ?? "",
                    nickname: item[nickname] ?? "",
                    introduce: item[introduce] ?? "",
                    gender: item[gender] ?? 0,
                    createdAt: item[createTime] ?? 0,
                    avatarURL: item[avatarURL] ?? "",
                    ipRegion: item[ipRegion] ?? "",
                    cookie: item[cookie] ?? ""
                ))
                #if DEBUG
                print("")
                #endif
            })
        } catch {
            #if DEBUG
            print(error)
            #endif
        }
    }
}
