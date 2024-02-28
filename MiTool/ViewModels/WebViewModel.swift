//
//  WebViewModel.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/7.
//

import SwiftUI

class WebViewModel: ObservableObject {
    @Published var url: URL?
    
    func fetchURL(sideBarType: SideBarType) {
        switch sideBarType {
        case .starRailMap:
            url = URL(string: "https://webstatic.mihoyo.com/sr/app/interactive-map/index.html")
        case .starRailWiki:
            url = URL(string: "https://bbs.mihoyo.com/sr/wiki/")
        default:
            break
        }
    }
}
