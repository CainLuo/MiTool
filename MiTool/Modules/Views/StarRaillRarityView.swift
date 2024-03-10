//
//  StarRaillRarityView.swift
//  MiTool
//
//  Created by Cain on 2024/2/27.
//

import SwiftUI
import Kingfisher

struct StarRaillRarityView: View {
    let rarity: RarityType
    let urlString: String
    var radius: CGFloat = 0
    
    var body: some View {
        KFImage(URL(string: urlString))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .background(
                LinearGradient(
                    gradient: rarity.ratityColor,
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .clipShape(
                .rect(
                    topTrailingRadius: radius
                )
            )
    }
}

#Preview {
    StarRaillRarityView(
        rarity: .five,
        urlString: "https://act-webstatic.mihoyo.com/darkmatter/hkrpg/prod_gf_cn/item_icon_ud9dkb/85c2d122caf1990fec39d657a027dc1a.png"
    )
        .frame(width: 168, height: 228)
}
