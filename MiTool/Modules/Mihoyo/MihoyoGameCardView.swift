//
//  MihoyoGameCardView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/18.
//

import SwiftUI
import Kingfisher
import SwiftUIX

struct MihoyoGameCardView: View {
    @StateObject var viewModel = MihoyoGameCardViewModel()

    let uid: String

    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 1
    )

    var body: some View {
        VStack {
            ForEach(viewModel.gameRecord) { item in
                ZStack {
                    KFImage(URL(string: item.backgroundImageV2))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .background(.red)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text(item.gameName)
                                .font(.system(size: 28, weight: .bold))
                                .multilineTextAlignment(.leading)
                                .padding(.top, 10)
                            Spacer()
                        }
                        
                        HStack {
                            Text(CopyGameName.uid + item.gameRoleID)
                                .font(.system(size: 18, weight: .bold))
                            Text(String(format: CopyGameName.regionName, item.regionName))
                                .font(.system(size: 18))
                        }
                        
                        HStack {
                            Text(String(format: CopyGameName.nickname, item.nickname))
                                .font(.system(size: 18))
                            Text(String(format: CopyGameName.level, item.level))
                                .font(.system(size: 18))
                        }
                        
                        if let data = item.data {
                            MihoyoGameCardDataView(data: data)
                        }
                    }
                    .padding()
                }
            }
        }
        .task {
            viewModel.getMihoyoGameCard(uid)
        }
    }
}

struct MihoyoGameCardDataView: View {
    let data: [MihoyoGameCardsDatum]

    var body: some View {
        HStack {
            ForEach(data) { dataItem in
                VStack(spacing: 8) {
                    Text("\(dataItem.name)")
                        .font(.system(size: 18))
                    Text("\(dataItem.value)")
                        .font(.system(size: 18))
                        .multilineTextAlignment(.center)
                }
            }
        }
    }
}

#Preview {
    MihoyoGameCardView(uid: "182692936")
        .frame(width: 600, height: 800)
}
