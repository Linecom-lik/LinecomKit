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
    @State var checkstatus = false
    var body: some View {
        List {
            Button("Check JSONRequest") {
                LinecomKit.NetworkAction.shared.requestJSON("https://api.linecom.net.cn/status/check") { resp succeed in
                    if succeed {
                        checkstatus = true
                    }
                }
            }
            if checkstatus {
                Text("successful!")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    ContentView()
}
