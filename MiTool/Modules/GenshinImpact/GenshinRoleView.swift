//
//  GenshinRoleView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import SwiftUI
import Kingfisher

struct GenshinRoleView: View {
    @StateObject var viewModel = GenshinRoleViewViewModel()
    
    var body: some View {
        List(viewModel.sections) { section in
            Section {
                ForEach(section.roleList) { item in
                    HStack {
                        KFImage(URL(string: item.icon ?? ""))
                            .sizeModifier()
                        
                        VStack {
                            Text("Lv.\(item.level ?? 1)")
                            HStack(spacing: .zero) {
                                Image(systemName: "heart")
                                Text("\(item.fetter ?? 1)")
                            }
                            Text("\(item.activedConstellationNum ?? 1)命")
                        }
                        
                        VStack {
                            Text(item.name ?? "")
                                .font(.system(size: 18, weight: .bold))
                            Text(" ")
                            Text(" ")
                        }
                        
                        if let weapon = item.weapon {
                            Spacer()
                            HStack {
                                VStack(alignment: .trailing) {
                                    Text(weapon.name ?? "")
                                        .font(.system(size: 18, weight: .bold))
                                    Text("Lv.\(weapon.level ?? 1)")
                                    Text("精\(weapon.affixLevel ?? 0)")
                                }
                                KFImage(URL(string: weapon.icon ?? ""))
                                    .sizeModifier()
                            }
                        }
                    }
                }
            } header: {
                HStack {
                    SectionHeaderView(
                        userName: section.userName,
                        uid: section.uid
                    )
                    
                    Spacer()
                }
                .padding([.top, .leading])
            }
        }
        .task {
            viewModel.fetchUserList()
        }
    }
}

#Preview {
    GenshinRoleView()
}
