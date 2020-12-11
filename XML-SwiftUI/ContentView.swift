//
//  ContentView.swift
//  XML-SwiftUI
//
//  Created by Felix Falkovsky on 12/11/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: RssViewModel
    var body: some View {
        NavigationView {
            NavigationLink(destination: PageView(viewModel: viewModel)) {
                Text("Open RSS")
                    .font(.custom("Avenir", size: 17, relativeTo: Font.TextStyle.largeTitle))
                    .foregroundColor(.blue)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: RssViewModel())
    }
}
