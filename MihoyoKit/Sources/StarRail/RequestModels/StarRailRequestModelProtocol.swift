//
//  StarRailRequestModelProtocol.swift
//
//
//  Created by Cain Luo on 2024/4/21.
//

import Foundation
import ObjectMapper

protocol StarRailRequestModelProtocol: Mappable {
    var uid: String? { set get }
}
