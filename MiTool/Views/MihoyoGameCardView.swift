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
    let uid: String
    
    @Environment (\.presentationMode) var presentationMode

    @StateObject var viewModel = MihoyoGameCardViewModel()
    
    var columns = Array(
        repeating: GridItem(.flexible()),
        count: 1
    )

    var body: some View {
        List(viewModel.gameRecord) { item in
            ZStack {
                KFImage(URL(string: item.backgroundImageV2))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .background(.red)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(item.gameName)
                            .font(.system(size: 24, weight: .bold))
                            .multilineTextAlignment(.leading)
                            .padding(.top, 10)
                        Spacer()
                    }
                                        
                    HStack {
                        Text(String(format: CopyGameName.uid, item.gameRoleID))
                        Text(String(format: CopyGameName.regionName, item.regionName))
                    }
                    
                    HStack {
                        Text(String(format: CopyGameName.nickname, item.nickname))
                        Text(String(format: CopyGameName.level, item.level))
                    }
                    
                    Text("语言：\(viewModel.language)")
                    
                    if let data = item.data {
                        MihoyoGameCardDataView(data: data)
                            .padding(.top, 10)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.getMihoyoGameCard(uid)
        }
    }
}

struct MihoyoGameCardDataView: View {
    let data: [MihoyoGameRecordDatum]
    
    var rows = Array(
        repeating: GridItem(.flexible()),
        count: 1
    )

    var body: some View {
        LazyHGrid(rows: rows) {
            ForEach(data) { dataItem in
                VStack(spacing: 8) {
                    Text("\(dataItem.name)")
                    Text("\(dataItem.value)")
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
