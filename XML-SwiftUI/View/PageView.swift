//
//  PageView.swift
//  XML-SwiftUI
//
//  Created by Felix Falkovsky on 12/11/20.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins
import SDWebImageSwiftUI

struct PageView: View {
    
    @ObservedObject var viewModel: RssViewModel
    @State private var filterIntensity = 0.5
    @State private var currentFilter = CIFilter.sepiaTone()
    @State var image: Image?
    @State private var isShow: Bool = false
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        return ZStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                Text("NEWS")
                    .font(.custom("Avenir", size: 35, relativeTo: Font.TextStyle.largeTitle))
                    .foregroundColor(.black)
                    .padding(.top, 30)
                let itemArray: [RssItem] = viewModel.getRssData()
                ForEach(itemArray) { item in
                    VStack(alignment: .center, spacing: 5, content: {
                        Text(item.title)
                            .font(.system(size: 22, weight: Font.Weight.medium, design: Font.Design.rounded))
                        Text(item.pubDate)
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: Font.Weight.light, design: Font.Design.rounded))
                        Text(item.description)
                            .foregroundColor(.gray)
                            .font(.system(size: 17, weight: Font.Weight.light, design: Font.Design.rounded))
                            .lineLimit(5)
                        WebImage(url: URL(string: item.enclosure))
                            .resizable()
                            .customLoopCount(1)
                            .playbackRate(1.0)
                            .aspectRatio(contentMode: .fit)
                        // Переход по ссылке
                        Button {
                          print(item.enclosure, type(of: item.enclosure))
                          print("\(itemArray)")
                          //  print(item.link, type(of: item.link))
                        } label: {
                            Text("PRINT")
                        }

                        Button {
                            if let url = URL(string: item.link) {
                            print(url.absoluteString)
                            print(UIApplication.shared.canOpenURL(url))
                            UIApplication.shared.open(url) }
                        } label: {
                            Text("Читать далее")
                        }
                        
                        image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Divider()
                    })
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            })
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        filterButton2()
                    } label: {
                        Image(systemName: "wand.and.stars")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Button {
                        filterButton1()
                    } label: {
                        Image(systemName: "wand.and.rays")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.all, 10)
                .padding(.top, 5)
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .background(BlurView(style: .systemMaterialDark))
                .clipShape(SChapes())
                .shadow(radius: 5)
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(viewModel: RssViewModel())
    }
}

struct SChapes: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35))
        return Path(path.cgPath)
    }
}

