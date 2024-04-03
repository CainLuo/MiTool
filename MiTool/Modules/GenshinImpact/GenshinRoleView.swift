//
//  GenshinRoleView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/3/24.
//

import SwiftUI
import Kingfisher

struct GenshinRoleView: View {
    @StateObject var viewModel = GenshinRoleViewModel()
    
    private enum Constants {
        static let spacing: CGFloat = 5
    }
    
    private let imageConfig = ViewConfiguration(borderColor: Color.gray.opacity(0.3), borderWidth: 4)
    private let skillConfig = ViewConfiguration(shape: .circle, frame: CGSize(width: 40, height: 40))

    var body: some View {
        List(viewModel.sections) { section in
            Section {
                ForEach(section.roleList) { item in
                    HStack {
                        HStack {
                            ImageView(
                                provider: .remote(url: item.avatarURL),
                                configuration: imageConfig
                            )
                            
                            VStack(spacing: Constants.spacing) {
                                Text(item.levelContent)
                                HStack(spacing: .zero) {
                                    Image(systemName: "heart")
                                    Text("\(item.fetter ?? 1)")
                                }
                                Text(item.constellation)
                            }
                        }
                        
                        VStack(spacing: Constants.spacing) {
                            Text(item.name ?? "")
                                .font(.system(size: 18, weight: .bold))
                            Text(" ")
                            Text(" ")
                        }
                        
                        HStack {
                            if let reliquaries = item.reliquaries {
                                HStack {
                                    ForEach(reliquaries) { reliquarie in
                                        VStack {
                                            ImageView(
                                                provider: .remote(url: reliquarie.iconURL),
                                                configuration: skillConfig
                                            )
                                            Text(reliquarie.levelString)
                                                .padding()
                                        }
                                    }
                                }
                            }
                            
                            if let skills = item.skillList {
                                VStack {
                                    ForEach(skills) { skill in
                                        if (skill.maxLevel ?? 0) >= 10 {
                                            HStack {
                                                ImageView(
                                                    provider: .remote(url: skill.skillURL),
                                                    configuration: skillConfig
                                                )
                                                Text(skill.level)
                                                    .padding()
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        
                        if let weapon = item.weapon {
                            Spacer()
                            HStack {
                                VStack(alignment: .trailing, spacing: Constants.spacing) {
                                    Text(weapon.name ?? "")
                                        .font(.system(size: 18, weight: .bold))
                                    Text(weapon.levelContent)
                                    Text(weapon.affixContent)
                                }                                
                                ImageView(
                                    provider: .remote(url: weapon.weaponURL),
                                    configuration: imageConfig
                                )
                            }
                        }
                    }
                    .padding()
                    .applyViewModifiers(
                        shape: .roundedRectangle(cornerRadius: 10),
                        backgroundColor: .black.opacity(0.4)
                    )
                    .frame(maxWidth: .infinity)
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
    @StateObject var viewModel: GenshinRoleViewModel
    
    let section: GenshinRoleSectionModel
    
    private enum Constants {
        static let buttonSize = CGSize(width: 120, height: 30)
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
                frame: Constants.buttonSize,
                isDisabled: $viewModel.isDisabled
            ) {
                viewModel.reloadGenshinCharacterSkills(
                    uid: section.uid
                )
            }

            PrimaryButton(
                title: CopyGenshinRole.skillsTitle,
                frame: Constants.buttonSize,
                isDisabled: $viewModel.isDisabled
            ) {
                viewModel.reloadGenshinCharacterSkills(
                    uid: section.uid
                )
            }
        }
        .padding()
    }
}

#Preview {
    GenshinRoleSectionView(
        viewModel: GenshinRoleViewModel(),
        section: GenshinRoleSectionModel()
    )
}

#Preview {
    GenshinRoleView()
}
