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
        ScrollView(.horizontal) {
            if viewModel.userList.isEmpty {
                MihoyoAddUserView(viewModel: viewModel)
                    .padding()
                    .border(cornerRadius: 8,
                            style: StrokeStyle(lineWidth: 1))
            } else {
                HStack {
                    ForEach(viewModel.userList) { user in
                        VStack {
                            MihoyoUserCardView(
                                viewModel: viewModel,
                                user: user
                            )
                            .padding(.top, 10)
                            
                            MihoyoGameCardView(uid: user.uid)
                        }
                        .border(cornerRadius: 8,
                                style: StrokeStyle(lineWidth: 1))
                        .padding()
                    }
                    .frame(width: 600)
                    
                    MihoyoAddUserView(viewModel: viewModel)
                        .padding()
                        .border(cornerRadius: 8,
                                style: StrokeStyle(lineWidth: 1))
                }
            }
        }
        .onAppear {
            viewModel.getMihoyoUserList()
        }
    }
}

struct MihoyoUserCardView: View {
    @StateObject var viewModel: MihoyoUserListViewModel

    let user: MihoyoUserListModel
    
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
                    
                    Text(String(format: CopyGameName.uid, user.uid))
                                        
                    Text(String(format: CopyGameName.region, user.ipRegion))
                }
            }
            .padding(.leading, 10)
            
            Spacer()
        }
    }
}

struct MihoyoAddUserView: View {
    @StateObject var viewModel: MihoyoUserListViewModel

    var body: some View {
        NavigationLink(destination: MihoyoUserEditView(viewModel: viewModel)) {
            HStack {
                HStack {
                    Image(systemName: "plus.app.fill")
                        .circleModifier(width: 60, height: 60)
                    Text(CopyGameName.addUser)
                        .font(.system(size: 20, weight: .semibold))
                }
                .padding(.leading, 10)
                
                Spacer()
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MihoyoUserListView()
        .frame(width: 1000, height: 1000)
}
