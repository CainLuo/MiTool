//
//  SQLManager+MihoyoUser.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import Foundation
import SQLite

private let index = Expression<Int64>("index")                      // 索引
private let uid = Expression<String?>("uid")                        // 米游社uid
private let cookie = Expression<String?>("cookie")                  // 米游社Cookie
private let sToken = Expression<String?>("sToken")                  // 米游社sToken-V2
private let deivceFP = Expression<String?>("deivceFP")              // 米游社设备签证
private let nickname = Expression<String?>("nickname")              // 昵称
private let communityInfo = Expression<String?>("communityInfo")    // 创建时间
private let introduce = Expression<String?>("introduce")            // 简介
private let gender = Expression<Int?>("gender")                     // 性别，0：保密，1：男，2：女
private let avatarURL = Expression<String?>("avatarURL")            // 头像链接
private let ipRegion = Expression<String?>("ipRegion")              // IP地址
private let region = Expression<String?>("region")                  // 服务器：China就是国服，Global就是外服

extension SQLManager {
    func createMihoyoUserTable(_ dataBase: Connection) {
        do {
            try dataBase.run(mihoyoUser.create(ifNotExists: true) { table in
                table.column(index, primaryKey: .autoincrement)
                table.column(uid, unique: true)
                table.column(cookie)
                table.column(sToken)
                table.column(deivceFP)
                table.column(nickname)
                table.column(communityInfo)
                table.column(introduce)
                table.column(gender)
                table.column(avatarURL)
                table.column(ipRegion)
                table.column(region)
            })
        } catch {
            Logger.error(error)
        }
    }

    func addMihoyoUser(
        _ model: MihoyoUserInfo,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let insert = mihoyoUser.insert(
                uid <- model.uid,
                nickname <- model.nickname,
                cookie <- model.cookie,
                sToken <- model.sToken,
                deivceFP <- model.deivceFP,
                communityInfo <- model.communityInfo?.toJSONString(),
                introduce <- model.introduce,
                gender <- model.gender,
                avatarURL <- model.avatarURL,
                ipRegion <- model.ipRegion,
                region <- model.region
            )
            try dataBase.run(insert)
            complete?(true, nil)
        } catch {
            complete?(false, error)
        }
    }
    
    func upgradeMihoyoUser(
        _ uuid: String,
        model: MihoyoUserInfo,
        complete: ((Bool, Error?) -> Void)?
    ) {
        do {
            let mihoyoUser = mihoyoUser.filter(uid == uuid)
            try dataBase.run(mihoyoUser.update(
                uid <- uuid,
                nickname <- model.nickname,
                cookie <- model.cookie,
                sToken <- model.sToken,
                deivceFP <- model.deivceFP,
                communityInfo <- model.communityInfo?.toJSONString(),
                introduce <- model.introduce,
                gender <- model.gender,
                avatarURL <- model.avatarURL,
                ipRegion <- model.ipRegion,
                region <- model.region
            ))
            complete?(true, nil)
        } catch {
            complete?(false, error)
        }
    }

    func removeMihoyoUsers() {
        do {
            if try dataBase.run(mihoyoUser.delete()) > 0 {
                Logger.info("删除所有用户成功")
            } else {
                Logger.error("没有找对应的用户")
            }
        } catch {
            Logger.error(error)
        }
    }

    func removeMihoyoUser(
        _ uuid: String,
        complete: ((Bool, Error?) -> Void)
    ) {
        let mihoyoUser = mihoyoUser.filter(uid == uuid)
        do {
            if try dataBase.run(mihoyoUser.delete()) > 0 {
                Logger.info("删除用户成功")
                complete(true, nil)
            } else {
                complete(false, nil)
            }
        } catch {
            Logger.error(error)
            complete(false, error)
        }
    }

    func getMihoyoUserList() -> [MihoyoUserInfo] {
        var list: [MihoyoUserInfo] = []
        do {
            try dataBase.transaction {
                try dataBase.prepare(mihoyoUser).forEach { item in
                    let account = MihoyoUserInfo(
                        uid: item[uid] ?? "",
                        nickname: item[nickname] ?? "",
                        introduce: item[introduce] ?? "",
                        gender: item[gender] ?? 1,
                        communityInfo: item[communityInfo],
                        avatarURL: item[avatarURL] ?? "",
                        ipRegion: item[ipRegion] ?? "",
                        cookie: item[cookie] ?? "",
                        sToken: item[sToken] ?? "",
                        deivceFP: item[deivceFP] ?? "",
                        region: item[region] ?? ""
                    )
                    list.append(account)
                }
            }
            return list
        } catch {
            Logger.error(error)
            return list
        }
    }

    func getMihoyoUser(
        _ uuid: String,
        complete: ((Bool, MihoyoUserInfo?) -> Void)?
    ) {
        let query = mihoyoUser.filter(uid == uuid)
        do {
            try dataBase.prepare(query).forEach { item in
                complete?(true, MihoyoUserInfo(
                    uid: item[uid] ?? "",
                    nickname: item[nickname] ?? "",
                    introduce: item[introduce] ?? "",
                    gender: item[gender] ?? 0,
                    communityInfo: item[communityInfo],
                    avatarURL: item[avatarURL] ?? "",
                    ipRegion: item[ipRegion] ?? "",
                    cookie: item[cookie] ?? "",
                    sToken: item[sToken] ?? "",
                    deivceFP: item[deivceFP] ?? "",
                    region: item[region] ?? ""
                ))
            }
            complete?(false, nil)
        } catch {
            Logger.error(error)
            complete?(false, nil)
        }
    }
}
