//
//  SideBarItemView.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI

struct SideBarItemView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var item: SideBarItemModel
    
    var animation: Namespace.ID
    var black = Color.black.opacity(0.5)

    @Binding var selection: SideBarType

    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selection = item.type
            }
        }, label: {
            HStack {
                Image(systemName: item.iconName)
                    .font(.title2)
                    .opacity(selection == item.type ? 1 : 0.5)
                    .frame(width: 25)
                
                Text(item.name)
                    .fontWeight(selection == item.type ? .semibold : .none)
                    .opacity(selection == item.type ? 1 : 0.5)
                
                Spacer()
                
                // Capsule...
                ZStack {
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 3, height: 25)
                    
                    if selection == item.type {
                        Capsule()
                            .fill(colorScheme == .light ? Color.black : Color.white)
                            .frame(width: 3, height: 25)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            }
            .padding(.leading)
        })
        .frame(height: 40)
        .buttonStyle(PlainButtonStyle())
    }
}
