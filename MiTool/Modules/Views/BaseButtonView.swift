//
//  BaseButtonView.swift
//  MiTool
//
//  Created by Cain on 2024/3/27.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var frame: CGSize?
    var action: () -> Void
    
    @Binding var isDisabled: Bool
    
    init(
        title: String,
        frame: CGSize? = nil,
        isDisabled: Binding<Bool>,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.frame = frame
        self.action = action
        self._isDisabled = isDisabled
    }

    init(
        title: String,
        frame: CGSize? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.frame = frame
        self.action = action
        self._isDisabled = .constant(true)
    }

    var body: some View {
        Button(action: action) {
            Text(title)
                .modifier(ButtonStyleModifier(isDisabled: isDisabled, frame: frame))
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!isDisabled)
    }
}

struct ButtonStyleModifier: ViewModifier {
    var isDisabled: Bool
    var frame: CGSize?

    func body(content: Content) -> some View {
        if let frame {
            content
                .foregroundColor(.white)
                .padding()
                .frame(width: frame.width, height: frame.height)
                .background(isDisabled ? Color.blue : Color.gray)
                .cornerRadius(10)
        } else {
            content
                .foregroundColor(.white)
                .padding()
                .background(isDisabled ? Color.blue : Color.gray)
                .cornerRadius(10)
        }
    }
}

#Preview {
    PrimaryButton(title: "这是一个按钮", isDisabled: .constant(true), action: { })
}