//
//  SideBar.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/4.
//

import SwiftUI
import Kingfisher

struct SideBar: View {
    @Binding var selection: SideBarType
    @State var selected = CopySideBar.notesTitle
    @Namespace var animation
    
    @StateObject var viewModel = SideBarViewModel()
    
    var body: some View {
        VStack {
            VStack {
                KFImage(viewModel.header.iconURL)
                    .placeholder({
                        Image(systemName: viewModel.header.iconName)
                            .circleModifier()
                    })
                    .circleModifier()
                    .padding(.top, 30)

                Text(viewModel.header.userName)
                    .fontWeight(.semibold)
                    .font(.system(size: 16))
                    .padding(.top, 10)
            }
            
            ScrollView {
                Group {
                    ForEach(viewModel.sections.indices, id: \.self) { index in
                        
                        let section = viewModel.sections[index]
                        if !section.sectionName.isEmpty {
                            Text(section.sectionName)
                                .padding()
                        }
                        ForEach(section.items) { item in
                            SideBarItemView(item: item,
                                            animation: animation,
                                            selection: $selection)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .frame(width: 200)
        .onAppear {
            viewModel.fetchSideBarHeader()
            viewModel.fetchSideBarSections()
        }
    }
}

#Preview {
    SideBar(selection: .constant(.notes))
        .frame(height: 700)
}
