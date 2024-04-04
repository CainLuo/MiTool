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

    var body: some View {
        List(viewModel.sections) { section in
            Section {
                ForEach(section.roleList) { item in
                    HStack {
                        GenshinRoleAvatarInfoView(item: item)
                        
                        HStack {
                            if let reliquaries = item.reliquaries {
                                GenshinRoleReliquariesView(reliquaries: reliquaries)
                            }
                            
                            if let skills = item.skillList {
                                GenshinRoleSkillsView(skills: skills)
                            }
                            
                            if let weapon = item.weapon {
                                Spacer()
                                GenshinRoleWeaponView(weapon: weapon)
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

struct GenshinRoleAvatarInfoView: View {
    private let imageConfig = ViewConfiguration(borderColor: Color.gray.opacity(0.3), borderWidth: 4)
    let item: GenshinCharacterAvatar
    
    private enum Constants {
        static let spacing: CGFloat = 5
    }

    var body: some View {
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
    }
}

struct GenshinRoleReliquariesView: View {
    private let skillConfig = ViewConfiguration(shape: .circle, frame: CGSize(width: 40, height: 40))

    let reliquaries: [GenshinCharacterReliquary]
    
    var body: some View {
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
}

struct GenshinRoleSkillsView: View {
    private let skillConfig = ViewConfiguration(shape: .circle, frame: CGSize(width: 40, height: 40))

    let skills: [GenshinRoleSkillItemModel]
    
    var body: some View {
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

struct GenshinRoleWeaponView: View {
    private let imageConfig = ViewConfiguration(borderColor: Color.gray.opacity(0.3), borderWidth: 4)

    let weapon: GenshinCharacterWeapon
    
    private enum Constants {
        static let spacing: CGFloat = 5
    }

    var body: some View {
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
