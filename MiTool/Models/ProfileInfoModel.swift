//
//  ProfileInfoModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import Foundation
import ObjectMapper

struct ProfileInfoModel: Mappable, Identifiable {
    var id = UUID()
    var uid: String?
    var username: String?
    var cookies: String?
    var gameID: Int?
    
    init?(map: ObjectMapper.Map) {
    }
    
    mutating func mapping(map: ObjectMapper.Map) {
        uid <- map["uid"]
        username <- map["username"]
        cookies <- map["cookies"]
    }
}
