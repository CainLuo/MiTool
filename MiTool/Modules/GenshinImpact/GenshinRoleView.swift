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
                GenshinRoleSectionView(viewModel: viewModel, section: section)
            }
        }
        .task {
            viewModel.fetchUserList()
        }
    }
}

struct GenshinRoleSectionView: View {
    @StateObject var viewModel: GenshinRoleViewViewModel
    
    let section: GenshinRoleSectionModel
    
    private enum Constants {
        static let height = 48
        static let width = 150
    }

    var body: some View {
        HStack {
            SectionHeaderView(
                userName: section.userName,
                uid: section.uid
            )
            
            Spacer()
                        
            PrimaryButton(
                title: CopyGenshinRole.rolesTitle,
                isDisabled: viewModel.$isDisabled
            ) {
                viewModel.reloadGenshinCharacterSkills(
                    uid: section.uid,
                    server: section.server
                )
            }

            PrimaryButton(
                title: CopyGenshinRole.skillsTitle,
                isDisabled: viewModel.$isDisabled
            ) {
                viewModel.reloadGenshinCharacterSkills(
                    uid: section.uid,
                    server: section.server
                )
            }
        }
        .padding()
    }
}

#Preview {
    GenshinRoleSectionView(
        viewModel: GenshinRoleViewViewModel(),
        section: GenshinRoleSectionModel()
    )
}

#Preview {
    GenshinRoleView()
}
