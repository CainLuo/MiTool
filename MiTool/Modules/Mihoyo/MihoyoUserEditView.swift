//
//  MihoyoUserEditView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/19.
//

import SwiftUI

struct MihoyoUserEditView: View {
    @Environment (\.presentationMode) var presentationMode
    
    var isNew = true
    var uid: String = ""
    
    @StateObject var viewModel = MihoyoUserEditViewModel()

    @State var selection = "China"
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    VStack {
                        Text(CopyGameName.inputNickname)
                        TextField(text: $viewModel.nickname)
                    }
                    
                    VStack {
                        Text(CopyGameName.uid)
                        TextField(text: $viewModel.uid)
                    }
                }

                HStack {
                    VStack {
                        Text(CopyGameName.sToken)
                        TextField(text: $viewModel.sTokenV2)
                    }
                    VStack {
                        Text(CopyGameName.deviceFP)
                        TextField(text: $viewModel.deivceFP)
                    }
                }
                
                Picker(
                    "Select Region",
                    selection: $selection
                ) {
                    ForEach(Region.regions.map { $0.value }, id: \.self) { region in
                        Text(region)
                    }
                }
                .pickerStyle(.menu)

                Text(CopyGameName.inputCookie)
                TextEditor(text: $viewModel.cookie)
                    .frame(maxHeight: 300)
                    .onChange(of: viewModel.cookie) { value in
                        if isNew {
                            viewModel.getMihoyoAuth(with: value)
                            viewModel.fetchMihoyoUserInfo(region: selection)
                        }
                    }
                Spacer()
            }
            .padding()
            
            PrimaryButton(title: CopyGameName.save) {
                viewModel.saveMihoyoUser(
                    region: selection
                )
                
                if viewModel.saveUserSuccess {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            .padding(.top, 0)
            .padding(.bottom, 10)
            .alert("保存用户失败了", isPresented: $viewModel.saveUserFailed) {
                Button("ok") {
                    viewModel.saveUserFailed.toggle()
                }
            }
        }
        .task {
            if !uid.isEmpty {
                viewModel.getUserInfo(uid: uid)
            }
        }
    }
}

#Preview {
    MihoyoUserEditView(viewModel: MihoyoUserEditViewModel())
        .frame(width: 600, height: 600)
}
