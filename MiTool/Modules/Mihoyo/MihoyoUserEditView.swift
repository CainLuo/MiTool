//
//  MihoyoUserEditView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/19.
//

import SwiftUI

struct MihoyoUserEditView: View {
    @Environment (\.presentationMode) var presentationMode
    
    @StateObject var viewModel = MihoyoUserEditViewModel()
    
    @State var nickename: String = ""
    @State var uid: String = ""
    @State var cookie: String = ""
    @State var sToken: String = ""
    @State var deivceFP: String = ""
    
    @State var selection = Region.china
    let regions: [Region] = [.china, .global]

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(CopyGameName.returnTitle)
                        .frame(width: 60, height: 28)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(8)
                })
                .buttonStyle(PlainButtonStyle())
                .padding([.leading, .top], 10)
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                
                HStack {
                    VStack {
                        Text(CopyGameName.inputNickname)
                        TextField(text: $nickename)
                    }
                    
                    VStack {
                        Text(CopyGameName.uid)
                        TextField(text: $uid)
                    }
                }

                HStack {
                    VStack {
                        Text(CopyGameName.sToken)
                        TextField(text: $sToken)
                    }
                    VStack {
                        Text(CopyGameName.deviceFP)
                        TextField(text: $deivceFP)
                    }
                }
                
                Picker(
                    "Select Region",
                    selection: $selection
                ) {
                    ForEach(regions, id: \.self) { region in
                        Text(region.rawValue)
                    }
                }
                .pickerStyle(.menu)

                Text(CopyGameName.inputCookie)
                TextEditor(text: $cookie)
                    .frame(maxHeight: 300)
                    .onChange(of: cookie) { value in
                        let strings = value.components(separatedBy: ";")
                        if let uidString = strings.filter({ $0.contains("stuid=") }).first {
                            let uid = uidString.replacingOccurrences(of: "stuid=", with: "")
                            self.uid = uid
                        }
                    }
                
                Spacer()
            }
            .padding()
            
            Button(action: {
                viewModel.saveMihoyoUser(
                    nickname: nickename,
                    uid: uid,
                    cookie: cookie, 
                    sToken: sToken,
                    deivceFP: deivceFP
                )
                
                if viewModel.saveUserSuccess {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text(CopyGameName.save)
                    .fontWeight(.semibold)
                    .frame(width: 200, height: 50)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(8)
            })
            .padding(.top, 0)
            .padding(.bottom, 10)
            .buttonStyle(PlainButtonStyle())
            .alert("保存用户失败了", isPresented: $viewModel.saveUserFailed) {
                Button("ok") {
                    viewModel.saveUserFailed.toggle()
                }
            }
        }
    }
}

#Preview {
    MihoyoUserEditView(viewModel: MihoyoUserEditViewModel())
        .frame(width: 600, height: 600)
}
