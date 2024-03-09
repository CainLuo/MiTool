//
//  MihoyoUserListView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/17.
//

import SwiftUI
import Kingfisher
import SwiftUIX

struct MihoyoUserListView: View {
    @StateObject var viewModel = MihoyoUserListViewModel()
    
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 2
    )

    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink(destination: MihoyoUserEditView()) {
                    Text(CopyGameName.addUser)
                        .frame(width: 120, height: 28)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }
            if !viewModel.userList.isEmpty {
                Spacer()
                Text("暂无任何用户信息")
                Spacer()
            } else {
                List {
                    ForEach(viewModel.userList) { user in
                        Section {
                            MihoyoGameCardView(uid: user.uid)
                        } header: {
                            MihoyoUserCardView(
                                viewModel: viewModel,
                                user: user
                            )
                            .padding(.top, 10)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
            }
        }
        .task {
            viewModel.getMihoyoUserList()
        }
    }
}

struct MihoyoUserCardView: View {
    @StateObject var viewModel: MihoyoUserListViewModel

    let user: MihoyoUserInfo
    
    var body: some View {
        HStack {
            HStack(spacing: 10) {
                KFImage(URL(string: user.avatarURL))
                    .placeholder {
                        Image(systemName: "person.circle.fill")
                            .circleModifier(width: 60, height: 60)
                    }
                    .circleModifier(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.nickname)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text("\(CopyGameName.uid)\(user.uid)")
                                        
                    Text(String(format: CopyGameName.region, user.ipRegion))
                }
            }
            .padding(.leading, 10)
            
            Spacer()
        }
    }
}

#Preview {
    MihoyoUserListView()
        .frame(width: 1000, height: 1000)
}
