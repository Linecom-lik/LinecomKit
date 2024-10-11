//
//  ContentView.swift
//  LinecomKit_Previews
//
//  Created by 程炜栋 on 2024/10/11.
//

import AlertKit
import SwiftUI
import LinecomKit

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                NStack {
                    VStack {
                        NeuButton(action: {
                            AlertKitAPI.present(title: "Test", subtitle: "Test Message", icon: .done, style: .iOS17AppleMusic, haptic: .success)
                        }, label: "Test Button")
                    }
                }
                .navigationTitle("Buttons")
                .tag(1)
                .tabItem {
                    Label("Button", systemImage: "square")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        NStack {
            NeuInput("Placeholder", icon: "globe", text: .constant(""))
        }
        NStack {
            NeuButton(action: {}, label: "Test Button")
        }
        NStack {
            NeuText("Neumorphic Text")
        }
        NStack {
            NeuProgressView(value: 30, total: 100, foregroundColor: .blue, width: 300, height: 18)
        }
        NStack {
            VStack {
                NeuToggle("NToggle On", isOn: .constant(true), tint: .blue)
                NeuToggle("NToggle Off", isOn: .constant(false))
                NeuToggle(isOn: .constant(true), label: {
                    Text("NToggle With View Label")
                })
            }
        }
        
    }
}
