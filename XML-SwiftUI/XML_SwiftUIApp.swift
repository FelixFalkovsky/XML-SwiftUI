//
//  XML_SwiftUIApp.swift
//  XML-SwiftUI
//
//  Created by Felix Falkovsky on 12/11/20.
//

import SwiftUI

@main
struct XML_SwiftUIApp: App {
    @ObservedObject var viewModel = RssViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
