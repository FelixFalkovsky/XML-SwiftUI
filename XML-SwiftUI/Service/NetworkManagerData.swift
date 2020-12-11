//
//  NetworkManagerData.swift
//  XML-SwiftUI
//
//  Created by Felix Falkovsky on 12/11/20.
//

import SwiftUI

class NetworkManagerData: NSObject, XMLParserDelegate {
    
    private var rssItems: [[Any]] = [[Any]]()
    
    override init() {
        super.init()
        for itemInt in 0..<Constant.tabs.count {
            let rssItemArray: [RssItem] = []
            rssItems.append(rssItemArray)
            self.updateRssData(itemInt)
        }
    }
    
    func loadRssFeed(itemInt: Int, compleationHandler: @escaping ([RssItem])->Void) {
        var rssItemArray: [RssItem] = []
        let feedURLs: [RSSUrl] = Constant.tabs[itemInt].feedList.feeds
        DispatchQueue.global(qos: .userInitiated).async {
            for urlFeed in 0..<feedURLs.count {
                let sUrl: String = Constant.tabs[itemInt].feedList.feeds[urlFeed].rUrl
                if let url = URL(string: sUrl) {
                    let item = self.loadRss(forFeedId: urlFeed, feedUrl: url)
                    rssItemArray.append(contentsOf: item)
                    self.rssItems[0] = rssItemArray
                }
            }
            compleationHandler(rssItemArray)
        }
    }
    
    func updateRssData(_ forTab: Int) {
        loadRssFeed(itemInt:forTab, compleationHandler: {
            let arrayOfItems = $0
            DispatchQueue.main.async {
                self.rssItems[forTab] = arrayOfItems
            }
        })
    }
    
    // Загрузка XML
    func loadRss(forFeedId: Int, feedUrl: URL) -> [RssItem]{
        var rssFeed : [AnyObject] = []
        var rssItemArray: [RssItem] = []
        let myParser : XmlParserManager = XmlParserManager().initWithURL(feedUrl) as! XmlParserManager
        
        rssFeed = myParser.feeds as [AnyObject]
        for item in rssFeed.indices {
            
            let postItem: AnyObject = rssFeed[item]
            var title: String = ""
            var pubDate: String = ""
            var description: String = ""
            var link: String = ""
            var enclosure: String = ""
            
            if postItem["title"] != nil {
                title = postItem["title"] as! String
            }
            
            if postItem["pubDate"] != nil {
                pubDate = postItem["pubDate"] as! String
            }
            
            if postItem["description"] != nil {
                description = postItem["description"] as! String
            }
            
            if postItem["link"] != nil {
                link = postItem["link"] as! String
                link = link.components(separatedBy: .newlines)[0]
            }
            
            if postItem["enclosure"] != nil {
                enclosure = postItem["enclosure"] as? String ?? ""
                enclosure = postItem["enclosure"].debugDescription
                enclosure = enclosure.components(separatedBy: .newlines)[1]
            }
            
            let rssItem: RssItem = RssItem(
                id: UUID(),
                title: title,
                description: description,
                pubDate: pubDate,
                enclosure: enclosure,
                link: link
            )
            rssItemArray.append(rssItem)
        }
        return rssItemArray
    }
    func getRssItemsForTab() -> [RssItem] {
        if let rssArray = rssItems[0] as? [RssItem], rssArray.count > 0 {
            return rssArray
        }
        return []
    }
}

