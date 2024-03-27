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
                            Text(item.levelContent)
                            HStack(spacing: .zero) {
                                Image(systemName: "heart")
                                Text("\(item.fetter ?? 1)")
                            }
                            Text(item.constellation)
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
                                    Text(weapon.levelContent)
                                    Text(weapon.affixContent)
                                }
                                KFImage(URL(string: weapon.icon ?? ""))
                                    .sizeModifier()
                            }
                        }
                    }
                    .padding()
                }
            } header: {
                HStack {
                    SectionHeaderView(
                        userName: section.userName,
                        uid: section.uid
                    )
                    
                    Spacer()
                    
                    Button {
                        viewModel.reloadGenshinCharacter(
                            uid: section.uid,
                            server: section.server
                        )
                    } label: {
                        Text("获取已有的所有角色")
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(8)
                    }

                    Button {
                        viewModel.reloadGenshinCharacterSkills(
                            uid: section.uid,
                            server: section.server
                        )
                    } label: {
                        Text("刷新已有的角色天赋")
                            .foregroundStyle(Color.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(8)
                    }
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
