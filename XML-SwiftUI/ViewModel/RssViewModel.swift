//
//  RssViewModel.swift
//  XML-SwiftUI
//
//  Created by Felix Falkovsky on 12/11/20.
//

import SwiftUI
import Foundation
import UIKit

class RssViewModel: ObservableObject {
    @Published var model = XmlParserManager()
    @Published  var rssData: NetworkManagerData
    private var lastUpdated: [String] = []

    init() {
        self.rssData = NetworkManagerData()
        for _ in 0..<Constant.tabs.count {
            self.lastUpdated.append(String (""))
        }
    }
    
    func getRssData() -> [RssItem] {
        return rssData.getRssItemsForTab()
    }
}

extension PageView {
        func filterButton1() {
            guard let inputImage = UIImage(named: "first") else { return }
            let beginImage = CIImage(image: inputImage)
            
            let context = CIContext()
            let currentFilter = CIFilter.crystallize()
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            currentFilter.radius = 100
            
            guard let outputImage = currentFilter.outputImage else { return }
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
             let uiImage = UIImage(cgImage: cgimg)
                image = Image(uiImage: uiImage)
            }
        }
        
        func filterButton2() {
            guard let inputImage = UIImage(named: "first") else { return }
            let beginImage = CIImage(image: inputImage)
            
            let context = CIContext()
            
            let currentFilter = CIFilter.sepiaTone()
            currentFilter.inputImage = beginImage
            currentFilter.intensity = 1
            
            guard let outputImage = currentFilter.outputImage else { return }
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
             let uiImage = UIImage(cgImage: cgimg)
                image = Image(uiImage: uiImage)
        }
    }
}


