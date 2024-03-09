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
            if viewModel.userList.isEmpty {
                Spacer()
                Text("暂无任何用户信息")
                    .padding()
                Spacer()
            } else {
                List {
                    ForEach(viewModel.userList) { user in
                        Section {
                            MihoyoGameCardView(uid: user.uid)
                        } header: {
                            NavigationLink(destination: 
                                            MihoyoUserEditView(
                                                nickename: user.nickname,
                                                uid: user.uid, 
                                                cookie: user.cookie ?? ""
                                            )
                            ) {
                                HStack {
                                    MihoyoUserCardView(
                                        viewModel: viewModel,
                                        user: user
                                    )
                                    .padding(.top, 10)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 20)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(
                    minWidth: 776,
                    maxHeight: .infinity
                )
            }
        }
        .onAppear {
            viewModel.getMihoyoUserList()
        }
    }
}

struct MihoyoUserCardView: View {
    @StateObject var viewModel: MihoyoUserListViewModel

    let user: MihoyoUserInfo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(user.nickname)
                    .font(.system(size: 18, weight: .semibold))
                Text("\(CopyGameName.uid)\(user.uid)")
                    .font(.system(size: 15))
            }
            Spacer()
        }
    }
}

#Preview {
    MihoyoUserListView()
        .frame(width: 1000, height: 1000)
}
