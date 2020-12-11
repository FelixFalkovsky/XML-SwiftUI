//
//  XmlParserManager.swift
//  XML-SwiftUI
//
//  Created by Felix Falkovsky on 12/11/20.
//

import SwiftUI

class XmlParserManager: NSObject, XMLParserDelegate  {
    
    var parser = XMLParser()
    var feeds = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var ftitle = NSMutableString()
    var link = NSMutableString()
    var enclosure: [String] = []
    var fdescription = NSMutableString()
    var fdate = NSMutableString()
    var img2 = NSMutableString()
    
    func initWithURL(_ url :URL) -> AnyObject {
        startParse(url)
        return self
    }
    
    func startParse(_ url :URL) {
        feeds = []
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
        parser.shouldProcessNamespaces = true
        parser.shouldReportNamespacePrefixes = true
        parser.shouldResolveExternalEntities = true
        parser.parse()
    }
    
    func allFeeds() -> NSMutableArray {
        return feeds
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if (element as NSString).isEqual(to: "item") {
            elements =  NSMutableDictionary()
            elements = [:]
            ftitle = NSMutableString()
            ftitle = ""
            link = NSMutableString()
            link = ""
            fdescription = NSMutableString()
            fdescription = ""
            fdate = NSMutableString()
            fdate = ""
            img2 = NSMutableString()
            img2 = ""
        } else if (element as NSString).isEqual(to: "enclosure") {
            if let urlString = attributeDict["url"] {
                enclosure.append(urlString as String)
            }
        }
    }
    
    
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

        if (elementName as NSString).isEqual(to: "item") {
            if ftitle != "" {
                elements.setObject(ftitle, forKey: "title" as NSCopying)
            }
            if link != "" {
                elements.setObject(link, forKey: "link" as NSCopying)
            }
            if fdescription != "" {
                elements.setObject(fdescription, forKey: "description" as NSCopying)
            }
            if fdate != "" {
                elements.setObject(fdate, forKey: "pubDate" as NSCopying)
            }
            if element != "" {
                elements.setObject(enclosure, forKey: "enclosure" as NSCopying)
           }
            feeds.add(elements)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "title") {
            ftitle.append(string)
        } else if element.isEqual(to: "link") {
            link.append(string)
        } else if element.isEqual(to: "description") {
            fdescription.append(string)
        } else if element.isEqual(to: "pubDate") {
            fdate.append(string)
        } else if element.isEqual(to: "enclosure") {
            enclosure.append(string)
        }
    }
}


