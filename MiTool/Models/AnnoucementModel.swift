//
//  AnnoucementModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/8.
//

import Foundation
import ObjectMapper

// MARK: - AnnoucementModel
struct AnnoucementModel: Mappable {
    var retcode: Int?
    var message: String?
    var data: AnnoucementDataModel?
    
    init() { }
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        retcode <- map["retcode"]
        message <- map["message"]
        data <- map["data"]
    }
}

// MARK: - AnnoucementDataModel
struct AnnoucementDataModel: Mappable {
    var list: [AnnoucementList]?
    var total: Int?
    var typeList: [AnnoucementPicElement]?
    var alert: Bool?
    var alertID, timezone: Int?
    var t: String?
    var picList: [AnnoucementPicList]?
    var picTotal: Int?
    var picTypeList: [AnnoucementPicElement]?
    var picAlert: Bool?
    var picAlertID: Int?
    var staticSign: String?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        list <- map["list"]
        total <- map["total"]
        typeList <- map["type_list"]
        alert <- map["alert"]
        alertID <- map["alert_id"]
        t <- map["t"]
        picList <- map["pic_list"]
        picTypeList <- map["pic_type_list"]
        picAlert <- map["pic_alert"]
        picAlertID <- map["pic_alert_id"]
        staticSign <- map["static_sign"]
    }
}

// MARK: - AnnoucementList
struct AnnoucementList: Mappable {
    var list: [AnnoucementListItem]?
    var typeID: Int?
    var typeLabel: String?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        list <- map["list"]
        typeID <- map["type_id"]
        typeLabel <- map["type_label"]
    }
}

// MARK: - AnnoucementListItem
struct AnnoucementListItem: Mappable, Identifiable {
    var id = UUID()
    var annID: Int?
    var title: String?
    var subtitle: String?
    var banner: String?
    var content: String?
    var typeLabel: String?
    var tagLabel: String?
    var tagIcon: String?
    var loginAlert: Int?
    var lang: String?
    var startTime: String?
    var endTime: String?
    var type: Int?
    var remind: Int?
    var alert: Int?
    var tagStartTime: String?
    var tagEndTime: String?
    var remindVer: Int?
    var hasContent: Bool?
    var extraRemind: Int?
    var tagIconHover: String?
    var picType: Int?
    var contentType: Int?
    var img: String?
    var hrefType: Int?
    var href: String?
    var picList: [Any?]?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        annID <- map["ann_id"]
        title <- map["title"]
        subtitle <- map["subtitle"]
        banner <- map["banner"]
        content <- map["content"]
        typeLabel <- map["type_label"]
        tagLabel <- map["tag_label"]
        tagIcon <- map["tag_icon"]
        loginAlert <- map["login_alert"]
        lang <- map["lang"]
        startTime <- map["start_time"]
        endTime <- map["end_time"]
        type <- map["type"]
        remind <- map["remind"]
        alert <- map["alert"]
        tagStartTime <- map["tag_start_time"]
        tagEndTime <- map["tag_end_time"]
        remindVer <- map["remind_ver"]
        hasContent <- map["has_content"]
        extraRemind <- map["extra_remind"]
        tagIconHover <- map["tag_icon_hover"]
        picType <- map["pic_type"]
        contentType <- map["content_type"]
        img <- map["img"]
        hrefType <- map["href_type"]
        href <- map["href"]
        picList <- map["pic_list"]
    }
}

// MARK: - PicList
struct AnnoucementPicList: Mappable {
    var typeList: [AnnoucementPicTypeList]?
    var typeID: Int?
    var typeLabel: String?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        typeList <- map["type_list"]
        typeID <- map["type_id"]
        typeLabel <- map["type_label"]
    }
}

// MARK: - PicListTypeList
struct AnnoucementPicTypeList: Mappable {
    var list: [AnnoucementListItem]?
    var picType: Int?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        list <- map["list"]
        picType <- map["pic_type"]
    }
}

// MARK: - PicTypeListElement
struct AnnoucementPicElement: Mappable {
    var id: Int?
    var name: String?
    var mi18NName: String?
    
    init?(map: ObjectMapper.Map) { }
    
    mutating func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        mi18NName <- map["mi18n_name"]
    }
}
