//
//  RoleCardView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/3.
//

import SwiftUI
import Kingfisher

struct RoleCardView: View {    
    let item: StarRailAllRoleListModel
    
    var body: some View {
        VStack {
            ZStack {
                KFImage(URL(string: item.iconURL ?? ""))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("前瞻")
                            .fontWeight(.semibold)
                            .foregroundColor(.purple)
                            .frame(width: 50)
                            .background(.yellow)
                    }
                }
                .opacity(item.isForward ?? false ? 1 : 0)
            }
            
            VStack {
                HStack {
                    Image(item.damageType?.damagetIcon ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 25)
                    
                    Image(item.avatarBaseType?.destinyIcon ?? "")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 25)
                    
                    Spacer()
                }
                .padding([.leading, .top, .trailing], 10)
                
                Text(item.itemName ?? "")
                    .fontWeight(.semibold)
                    .padding(.top, 10)
            }
        }
    }
}

#Preview {
    RoleCardView(item: 
                    StarRailAllRoleListModel(itemName: "",
                                     iconURL: "https://act-webstatic.mihoyo.com/darkmatter/hkrpg/prod_gf_cn/item_icon_u17ehb/cbf5a53b27530f3b626aedc65679a3d3.png",
                                     targetLevel: 1)
    )
    .frame(width: 400, height: 600)
}
