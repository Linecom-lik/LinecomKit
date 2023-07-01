//
//  UIExt.swift
//  DarockKit
//
//  Created by WindowsMEMZ on 2023/6/29.
//

import Foundation
import SwiftUI

public struct CenterAlign: ViewModifier {
    public func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}

public struct NoAutoInput: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

//MARK: Neumorphic
@ViewBuilder public func NeuInput(_ placeholder: String, icon: String, text: Binding<String>, password: Bool = false, paddings: [CGFloat] = [5, 20], noAutoInput: Bool = false) -> some View {
    VStack {
        HStack {
            if icon != "" {
                Image(systemName: icon)
                    .foregroundColor(.Neumorphic.secondary)
                    .font(.system(size: 20, weight: .bold))
            }
            if password {
                SecureField(placeholder, text: text)
                    .foregroundColor(.Neumorphic.secondary)
            } else {
                if noAutoInput {
                    TextField(placeholder, text: text)
                        .foregroundColor(.Neumorphic.secondary)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                } else {
                    TextField(placeholder, text: text)
                        .foregroundColor(.Neumorphic.secondary)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.Neumorphic.main)
                .softInnerShadow(RoundedRectangle(cornerRadius: 30), darkShadow: .Neumorphic.darkShadow, lightShadow: .Neumorphic.lightShadow, spread: 0.05, radius: 2)
        )
    }
    .padding(.vertical, paddings[0])
    .padding(.horizontal, paddings[1])
}

@ViewBuilder public func NeuButton(action: @escaping () -> Void, label: LocalizedStringKey, icon: String? = nil, cornerRadius: CGFloat = 18, paddings: [CGFloat] = [5, 20], fontSize: CGFloat = 22, fontWeight: Font.Weight = .bold, width: CGFloat? = nil) -> some View {
    Button(action: {
        action()
    }, label: {
        HStack {
            Spacer()
            Group {
                if icon != nil {
                    Image(systemName: icon!)
                }
                Text(label)
            }
            .font(.system(size: fontSize, weight: fontWeight))
            Spacer()
        }
    })
    .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius))
    .frame(width: width)
    .padding(.vertical, paddings[0])
    .padding(.horizontal, paddings[1])
}
@ViewBuilder public func NeuButton(action: @escaping () -> Void, label: String, icon: String? = nil, cornerRadius: CGFloat = 18, paddings: [CGFloat] = [5, 20], fontSize: CGFloat = 22, fontWeight: Font.Weight = .bold, width: CGFloat? = nil) -> some View {
    Button(action: {
        action()
    }, label: {
        HStack {
            Spacer()
            Group {
                if icon != nil {
                    Image(systemName: icon!)
                }
                Text(label)
            }
            .font(.system(size: fontSize, weight: fontWeight))
            Spacer()
        }
    })
    .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius))
    .frame(width: width)
    .padding(.vertical, paddings[0])
    .padding(.horizontal, paddings[1])
}
@ViewBuilder public func NeuButton(action: @escaping () -> Void, label: () -> some View, cornerRadius: CGFloat = 18, paddings: [CGFloat] = [5, 20], fontSize: CGFloat = 22, fontWeight: Font.Weight = .bold, width: CGFloat? = nil) -> some View {
    Button(action: {
        action()
    }, label: {
        label()
    })
    .softButtonStyle(RoundedRectangle(cornerRadius: cornerRadius))
    .frame(width: width)
    .padding(.vertical, paddings[0])
    .padding(.horizontal, paddings[1])
}

@ViewBuilder public func NStack(_ main: () -> some View) -> some View {
    ZStack {
        Color.Neumorphic.main
            .ignoresSafeArea()
        main()
    }
}

@ViewBuilder public func NeuText(_ text: LocalizedStringKey, fontSize: CGFloat = 22) -> some View {
    Text(text)
        .font(.system(size: fontSize, weight: .bold))
        .foregroundColor(.Neumorphic.secondary)
}
@ViewBuilder public func NeuText(_ text: String, fontSize: CGFloat = 22) -> some View {
    Text(text)
        .font(.system(size: fontSize, weight: .bold))
        .foregroundColor(.Neumorphic.secondary)
}


