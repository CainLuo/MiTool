//
//  KFImageShapeStyle.swift
//  MiTool
//
//  Created by Cain Luo on 2024/4/3.
//

import SwiftUI
import Kingfisher

enum ImageProvider {
    case remote(url: String)
    case local(imageName: String)
}

struct ImageView: View {
    let provider: ImageProvider
    let placeholder: Image? = nil
    let configuration: ViewConfiguration

    var body: some View {
        switch provider {
        case .remote(let url):
            KFImage(URL(string: url))
                .placeholder {
                    placeholder
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .applyViewModifiers(
                    shape: configuration.shape,
                    frame: configuration.frame,
                    backgroundColor: configuration.backgroundColor,
                    borderColor: configuration.borderColor,
                    borderWidth: configuration.borderWidth
                )
        case .local(let imageName):
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .applyViewModifiers(
                    shape: configuration.shape,
                    frame: configuration.frame,
                    backgroundColor: configuration.backgroundColor,
                    borderColor: configuration.borderColor,
                    borderWidth: configuration.borderWidth
                )
        }
    }
}

private struct ImageViewModifiers: ViewModifier {
    let shape: Shape
    let frame: CGSize?
    let backgroundColor: Color?
    let borderColor: Color?
    let borderWidth: CGFloat

    func body(content: Content) -> some View {
        content
            .applyBackground(backgroundColor)
            .applyFrame(frame)
            .applyShape(shape)
            .applyBorder(shape, color: borderColor, width: borderWidth, frame: frame)
    }
}

extension View {
    func applyViewModifiers(
        shape: Shape,
        frame: CGSize? = nil,
        backgroundColor: Color? = nil,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 0
    ) -> some View {
        self.modifier(
            ImageViewModifiers(
                shape: shape,
                frame: frame,
                backgroundColor: backgroundColor,
                borderColor: borderColor,
                borderWidth: borderWidth
            )
        )
    }
}

extension View {
    @ViewBuilder
    func applyShape(_ shape: Shape) -> some View {
        switch shape {
        case .circle:
            self.clipShape(Circle())
        case .roundedRectangle(let cornerRadius):
            self.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }

    @ViewBuilder
    func applyFrame(_ frame: CGSize?) -> some View {
        if let frame = frame {
            self.frame(width: frame.width, height: frame.height)
        } else {
            self
        }
    }

    @ViewBuilder
    func applyBackground(_ color: Color?) -> some View {
        if let color = color {
            self.background(color)
        } else {
            self
        }
    }

    @ViewBuilder
    func applyBorder(
        _ shape: Shape,
        color: Color?,
        width: CGFloat,
        frame: CGSize?
    ) -> some View {
        if let color = color {
            switch shape {
            case .circle:
                self.overlay {
                    Circle()
                        .strokeBorder(color, lineWidth: width)
                        .frame(
                            width: (frame?.width ?? 0) + width,
                            height: (frame?.height ?? 0) + width
                        )
                }
            case .roundedRectangle(let cornerRadius):
                self.overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(color, lineWidth: width)
                        .frame(
                            width: (frame?.width ?? 0) + width,
                            height: (frame?.height ?? 0) + width
                        )
                )
            }
        } else {
            self
        }
    }
}
