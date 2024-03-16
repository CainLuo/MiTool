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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            switch sideBarType {
            case .starRailMap:
                self.url = URL(string: "https://webstatic.mihoyo.com/sr/app/interactive-map/index.html")
            case .starRailWiki:
                self.url = URL(string: "https://bbs.mihoyo.com/sr/wiki/")
            case .genshinImpactMap:
                self.url = URL(string: "https://act.mihoyo.com/ys/app/interactive-map/index.html")
            case .genshinImpactWiki:
                self.url = URL(string: "https://bbs.mihoyo.com/ys/obc/")
            default:
                break
            }
        }
    }
}
