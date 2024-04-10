//
//  MihoyoModel.swift
//  MiTool
//
//  Created by Cain on 2024/4/10.
//

import Foundation
import ObjectMapper

protocol MihoyoModelProtocol: Mappable {
    associatedtype MihoyoDataModelProtocol
    
    var retcode: Int { set get }
    var message: String { set get }
    var data: MihoyoDataModelProtocol? { set get }
}

protocol MihoyoDataModelProtocol: Mappable, Identifiable { }
