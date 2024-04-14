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

    var body: some View {
        List(viewModel.sections) { section in
            Section {
                ForEach(section.items) { item in
                    HStack {
                        GenshinRoleAvatarInfoView(item: item.roleItem)
                        HStack {
                            if let reliquaries = item.roleItem.reliquaries {
                                GenshinRoleReliquariesView(reliquaries: reliquaries)
                            }
                            
                            if let skills = item.roleItem.skillList {
                                GenshinRoleSkillsView(skills: skills)
                            }
                            
                            if let weapon = item.roleItem.weapon {
                                Spacer()
                                GenshinRoleWeaponView(weapon: weapon)
                            }
                        }
                        .frame(maxWidth: .infinity)
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

struct GenshinRoleAvatarInfoView: View {
    private let imageConfig = ViewConfiguration()
    
    let item: GenshinCharacterAvatar
    
    private enum Constants {
        static let spacing: CGFloat = 5
    }

    var body: some View {
        HStack {
            ImageView(
                provider: .remote(item.avatarURL),
                configuration: imageConfig
            )
            .background(
                item.rarity.ratityColor
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
    }
}

struct GenshinRoleReliquariesView: View {
    private let skillConfig = ViewConfiguration(
        shape: .circle,
        frame: CGSize(width: 40, height: 40)
    )

    let reliquaries: [GenshinCharacterReliquary]
    
    var body: some View {
        HStack {
            ForEach(reliquaries) { reliquary in
                VStack {
                    ImageView(
                        provider: .remote(reliquary.iconURL),
                        configuration: skillConfig
                    )
                    Text(reliquary.levelString)
                        .padding()
                }
            }
        }
    }
}

struct GenshinRoleSkillsView: View {
    private let skillConfig = ViewConfiguration(
        shape: .circle, 
        frame: CGSize(width: 40, height: 40)
    )

    let skills: [GenshinRoleSkillItemModel]
    
    var body: some View {
        VStack {
            ForEach(skills) { skill in
                if (skill.maxLevel) >= 10 {
                    HStack {
                        ImageView(
                            provider: .remote(skill.skillURL),
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

struct GenshinRoleWeaponView: View {
    private let imageConfig = ViewConfiguration(
        shape: .circle,
        borderColor: Color.gray.opacity(0.3),
        borderWidth: 4
    )

    let weapon: GenshinCharacterWeapon
    
    private enum Constants {
        static let spacing: CGFloat = 5
    }

    var body: some View {
        HStack {
            VStack(alignment: .trailing, spacing: Constants.spacing) {
                Text(weapon.name ?? "")
                    .font(.system(size: 18, weight: .bold))
                Text("\(weapon.level)")
//                Text(weapon.affixContent)
            }
            ImageView(
                provider: .remote(weapon.icon ?? ""),
                configuration: imageConfig
            )
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
//                viewModel.reloadGenshinCharacterSkills(
//                    uid: section.uid
//                )
            }

            PrimaryButton(
                title: CopyGenshinRole.skillsTitle,
                frame: Constants.buttonSize,
                isDisabled: $viewModel.isDisabled
            ) {
//                viewModel.reloadGenshinCharacterSkills(
//                    uid: section.uid
//                )
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
