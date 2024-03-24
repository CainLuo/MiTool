//
//  StarRailRoleDetailView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/7.
//

import SwiftUI

struct StarRailRoleDetailView: View {
    @Environment (\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Button")
        })
    }
}
    
#Preview {
    StarRailRoleDetailView()
}
