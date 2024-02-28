//
//  Image+Extensions.swift
//  MiTool
//
//  Created by Cain Luo on 2024/2/6.
//

import SwiftUI
import Kingfisher

extension Image {
    func circleModifier(width: CGFloat = 90,
                        height: CGFloat = 90) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
    
    func sizeModifier(width: CGFloat = 90,
                      height: CGFloat = 90) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
    }
    
    func sizeFillModifier(width: CGFloat = 90,
                          height: CGFloat = 90) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
}

extension KFImage {
    func circleModifier(width: CGFloat = 90,
                        height: CGFloat = 90) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
            .clipShape(Circle())
    }
    
    func sizeModifier(width: CGFloat = 90,
                      height: CGFloat = 90) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height)
    }
    
    func sizeFillModifier(width: CGFloat = 90,
                          height: CGFloat = 90) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
    }
}
