//
//  AnnoucementContentModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/8.
//

import Foundation
import ObjectMapper

// MARK: - AnnoucementContentModel
struct AnnoucementContentModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: AnnoucementContentDataModel?
    
    init() { }
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - AnnoucementContentDataModel
struct AnnoucementContentDataModel: Mappable {
    var list: [AnnoucementContentItem]?
    var total: Int?
    var picList: [AnnoucementContentPicItem]?
    var picTotal: Int?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        list <- map["list"]
        total <- map["total"]
        picList <- map["pic_list"]
        picTotal <- map["picTotal"]
    }
}

// MARK: - AnnoucementContentPicList
struct AnnoucementContentItem: Mappable {
    var annID: Int?
    var title: String?
    var subtitle: String?
    var banner: String?
    var content: String?
    var lang: String?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        annID <- map["ann_id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        banner <- map["banner"]
        content <- map["content"]
        lang <- map["lang"]
    }
}

// MARK: - AnnoucementContentPicListItem
struct AnnoucementContentPicItem: Mappable {
    var annID: Int?
    var contentType: Int?
    var title: String?
    var subtitle: String?
    var banner: String?
    var content: String?
    var lang: String?
    var img: String?
    var hrefType: Int?
    var href: String?
    var picList: [Any?]?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        annID <- map["ann_id"]
        contentType <- map["contentType"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        banner <- map["banner"]
        content <- map["content"]
        lang <- map["lang"]
        img <- map["img"]
        hrefType <- map["hrefType"]
        href <- map["href"]
        picList <- map["picList"]
    }
}
