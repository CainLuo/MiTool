//
//  ThemeColor.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI

typealias RoleBgColor = ThemeColor.StarRail

enum ThemeColor {
    enum StarRail {
        static let fiveTop = Color("FiveStarTop")
        static let fiveBottom = Color("FiveStarBottom")
        static let fourTop = Color("FourStarTop")
        static let fourBottom = Color("FourStarBottom")
        
        static func fiveColor() -> LinearGradient {
            LinearGradient(colors: [StarRail.fiveTop, StarRail.fiveBottom],
                           startPoint: .top,
                           endPoint: .bottom)
        }
        
        static func fourColor() -> LinearGradient {
            LinearGradient(colors: [StarRail.fourTop, StarRail.fourBottom],
                           startPoint: .top,
                           endPoint: .bottom)
        }
    }
}
