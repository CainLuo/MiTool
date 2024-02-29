//
//  SQLManager.swift
//  Barbatos
//
//  Created by Cain J H LUO_SP on 2022/10/22.
//

import Foundation
import SQLite

class SQLManager {
    static let shared = SQLManager()
    
    private init() { }
    
    open private(set) var dataBase: Connection!
    
    let starRailRole = Table("starRailRole")
    let starRailRoleSkill = Table("starRailRoleSkill")
    let starRailDailyNode = Table("StarRailDailyNode")
    let starRailRoleCompute = Table("starRailRoleCompute")
    let mihoyoUser = Table("MihoyoUser")

    // 获取/设置数据库User version
    var userVersion: Int32 {
        get {
            do {
                let version = try dataBase?.scalar("PRAGMA user_version") as? Int64
                return Int32(version ?? 0)
            } catch {
                #if DEBUG
                print(error)
                #endif
            }
            return 0
        } set {
            do {
                try dataBase?.run("PRAGMA user_version = \(newValue)")
            } catch {
                #if DEBUG
                debugPrint(error)
                #endif
            }
        }
    }
    
    /// 链接SQLite数据库
    func connectDataBase() {
        guard let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true
        ).first else {
            return
        }
        
        debugPrint("⚠️⚠️⚠️ ---------- Database path: \(path)/db.sqlite3 ---------- ⚠️⚠️⚠️")
        
        do {
            dataBase = try Connection("\(path)/db.sqlite3")
            dataBase.busyTimeout = 5
            dataBase.busyHandler { tries in
                tries < 3
            }
            createMihoyoGameCardTable(dataBase)
            creteStarRailRoleTable(dataBase)
            cretestarRailRoleComputeTable(dataBase)
            creteStarRailRoleSkillTable(dataBase)
        } catch {
            #if DEBUG
            debugPrint("💥💥💥 ---------- \(error.localizedDescription) ---------- 💥💥💥")
            #endif
        }
    }
    
    /// 判断表中是否存在该column
    /// - Parameters:
    ///   - table: String
    ///   - column: String
    /// - Returns: Bool
    func columns(table: String, column: String) -> Bool {
        do {
            var columns: [String] = []
            let statement = try dataBase.prepare("PRAGMA table_info(" + table + ")")
            
            statement.forEach { row in
                if let column = row[1] as? String {
                    columns.append(column)
                }
            }
            
            let list = columns.filter { $0 == column }
            return !list.isEmpty
        } catch {
            return false
        }
    }
}
