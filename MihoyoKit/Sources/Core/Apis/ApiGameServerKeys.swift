//
//  EnumKeys.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/25.
//

import SwiftUI
import Foundation

/// HonKai: Star Rail Server
/// gdCN: China Server
/// qdCN: China Server, like XiaoMi, Bilibili server
/// officialUSA: USA Server
/// officialEURO: Euro Server
/// officialASIA: Asia Server
/// officialCHT: Cht Server
enum StarRailServerType: String {
    case gdCN = "prod_gf_cn"
    case qdCN = "prod_qd_cn"
    case officialUSA = "prod_official_usa"
    case officialEURO = "prod_official_euro"
    case officialASIA = "prod_official_asia"
    case officialCHT = "prod_official_cht"
}

/// Genshin Impact Server
/// gfCN: Mihoyo Server
/// qdCN: China Server, like XiaoMi, Bilibili Server
enum GenshinServerType: String {
    case gfCN = "cn_gf01"
    case qdCN = "cn_qd01"
}

enum StarRailGameBiz: String {
    case china = "hkrpg_cn"
}

enum GenshinGameBiz: String {
    case china = "hk4e_cn"
}
