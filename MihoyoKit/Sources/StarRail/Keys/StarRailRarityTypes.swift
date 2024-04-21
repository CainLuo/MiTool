//
//  StarRailRarityTypes.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/9.
//

import SwiftUI

public enum StarRailRarityTypes: String {
    case one = "1"      // 一星
    case two = "2"      // 二星
    case three = "3"    // 三星
    case four = "4"     // 四星
    case five = "5"     // 五星

    public var ratityColor: Gradient {
        switch self {
        case .one:
            return Gradient(colors: [
                Color(hexadecimal6: 0x484B59),
                Color(hexadecimal6: 0x7F8088)
            ])
        case .two:
            return Gradient(colors: [
                Color(hexadecimal6: 0x394C65),
                Color(hexadecimal6: 0x418082)
            ])
        case .three:
            return Gradient(colors: [
                Color(hexadecimal6: 0x3D4371),
                Color(hexadecimal6: 0x4575B4)
            ])
        case .four:
            return Gradient(colors: [
                Color(hexadecimal6: 0x404066),
                Color(hexadecimal6: 0x9864CE)
            ])
        case .five:
            return Gradient(colors: [
                Color(hexadecimal6: 0x925C52),
                Color(hexadecimal6: 0xC6A470)
            ])
        }
    }

    public var ratityImage: String {
        "starRailRarity\(self.rawValue)"
    }
}
