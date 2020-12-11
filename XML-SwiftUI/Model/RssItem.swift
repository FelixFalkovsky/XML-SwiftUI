//
//  RssItem.swift
//  XML-SwiftUI
//
//  Created by Felix Falkovsky on 12/11/20.
//

import Foundation


struct RssItem: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var pubDate: String
    var enclosure: String = ""
    var link: String = ""
}
