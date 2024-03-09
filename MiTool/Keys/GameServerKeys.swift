//
//  EnumKeys.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/25.
//

import SwiftUI
import Foundation

enum StarRailServerType: String {
    case gdCN = "prod_gf_cn"
    case qdCN = "prod_qd_cn"
    case officialUSA = "prod_official_usa"
    case officialEURO = "prod_official_euro"
    case officialASIA = "prod_official_asia"
    case officialCHT = "prod_official_cht"
}

enum GenshinImpactServerType: String {
    case gfCN = "cn_gf01"
    case qdCN = "cn_qd01"
}
