//
//  SQLManager+MihoyoUser.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import Foundation
import SQLite

private let index = Expression<Int64>("index")              // 索引
private let uid = Expression<String?>("uid")                // 米游社uid
private let cookie = Expression<String?>("cookie")          // 米游社Cookie
private let nickname = Expression<String?>("nickname")      // 昵称
private let createTime = Expression<Int?>("createTime")     // 创建时间
private let introduce = Expression<String?>("introduce")    // 简介
private let gender = Expression<Int?>("gender")             // 性别，0：保密，1：男，2：女
private let avatarURL = Expression<String?>("avatarURL")    // 头像链接
private let ipRegion = Expression<String?>("ipRegion")      // 头像链接
private let gameCard = Expression<String?>("gameCard")      // 游戏卡片，原神id：1，星穹铁道id：6

extension SQLManager {
    func createMihoyoGameCardTable(_ dataBase: Connection) {
        do {
            try dataBase.run(mihoyoUser.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid, unique: true)
                table.column(cookie)
                table.column(nickname)
                table.column(createTime)
                table.column(introduce)
                table.column(gender)
                table.column(avatarURL)
                table.column(ipRegion)
                table.column(gameCard)
            })
        } catch {
            #if DEBUG
            print(error)
            #endif
        }
    }

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
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            complete?(false, error)
        }
    }

    func removeMihoyoUsers() {
        do {
            if try dataBase.run(mihoyoUser.delete()) > 0 {
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

    func removeMihoyoUser(
        _ uuid: String,
        complete: ((Bool, Error?) -> Void)
    ) {
        let mihoyoUser = mihoyoUser.filter(uid == uuid)
        do {
            if try dataBase.run(mihoyoUser.delete()) > 0 {
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

    func upgradeMihoyoAccount(
        _ model: MihoyoUserInfo,
        mihoyoCookie: String,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let mihoyoUser = mihoyoUser.filter(uid == model.uid)
                try dataBase.run(mihoyoUser.update(
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

    func upgradeMihoyoUserCookie(
        _ uuid: String,
        mihoyoCookie: String,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let mihoyoUser = mihoyoUser.filter(uid == uuid)
                try dataBase.run(mihoyoUser.update(
                    cookie <- mihoyoCookie
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }

    func upgradeMihoyoUserGameCard(
        _ uuid: String,
        gameCardJSON: String,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            try dataBase.transaction {
                let mihoyoUser = mihoyoUser.filter(uid == uuid)
                try dataBase.run(mihoyoUser.update(
                    gameCard <- gameCardJSON
                ))
                complete?(true, nil)
            }
        } catch {
            complete?(false, error)
        }
    }

    func getMihoyoUserList() -> [MihoyoUserListModel] {
        var list: [MihoyoUserListModel] = []
        do {
            try dataBase.transaction {
                try dataBase.prepare(mihoyoUser).forEach { item in
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
                }
            }
            return list
        } catch {
            #if DEBUG
            print(error)
            #endif
            return list
        }
    }

    func getMihoyoUser(_ uuid: String, complete: ((_ model: MihoyoUserListModel) -> Void)?) {
        let query = mihoyoUser.filter(uid == uuid)
        do {
            try dataBase.prepare(query).forEach { item in
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
            }
        } catch {
            #if DEBUG
            print(error)
            #endif
        }
    }
}
