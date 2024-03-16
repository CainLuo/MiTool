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
                .padding([.trailing, .top], 10)
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
                                                isNew: false,
                                                uid: user.uid
                                            )
                            ) {
                                HStack {
                                    SectionHeaderView(
                                        userName: user.nickname,
                                        uid: user.uidString
                                    )

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

#Preview {
    MihoyoUserListView()
        .frame(width: 1000, height: 1000)
}
