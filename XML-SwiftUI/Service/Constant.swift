//
//  Constant.swift
//  XML-SwiftUI
//
//  Created by Felix Falkovsky on 12/11/20.
//

import Foundation

struct Selected {
    var feedList:FeedList
}

struct FeedList {
    var feeds: [RSSUrl]
}

struct RSSUrl {
    var rUrl:String
}

struct Constant {
    static let feed1: RSSUrl = RSSUrl(rUrl: "https://lenta.ru/rss/articles")
    static let aList:FeedList = FeedList(feeds: [feed1])
    static let tab0:Selected = Selected(feedList: aList)
    
//    static let feed2: RSSUrl = RSSUrl(rUrl: "https://habr.com/ru/rss/hubs/all/")
//    static let bList:FeedList = FeedList(feeds: [feed2])
//    static let tab1:Selected = Selected(feedList: bList)
//
    static let tabs:[Selected] = [tab0]
}
