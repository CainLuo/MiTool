//
//  MihoyoUserEditView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/19.
//

import SwiftUI

struct MihoyoUserEditView: View {
    @Environment (\.presentationMode) var presentationMode
    
    @StateObject var viewModel: MihoyoUserListViewModel
    
    @State var nickename: String = ""
    @State var uid: String = ""
    @State var cookie: String = ""

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
                Text(CopyGameName.inputNickname)
                TextField(text: $nickename)
                
                Text(CopyGameName.uid)
                TextField(text: $uid)

                Text(CopyGameName.inputCookie)
                TextEditor(text: $cookie)
                    .onChange(of: cookie) { value in
                        let strings = value.components(separatedBy: ";")
                        if let uidString = strings.filter({ $0.contains("stuid=") }).first {
                            let uid = uidString.replacingOccurrences(of: "stuid=", with: "")
                            self.uid = uid
                        }
                    }
            }
            .padding()
            
            Button(action: {
                viewModel.saveMihoyoUser(
                    nickname: nickename,
                    uid: uid,
                    cookie: cookie
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
        }
    }
}

#Preview {
    MihoyoUserEditView(viewModel: MihoyoUserListViewModel())
        .frame(width: 600, height: 600)
}

