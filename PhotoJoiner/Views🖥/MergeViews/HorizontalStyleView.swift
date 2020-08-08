//
//  HorizontalStyleView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 03.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import SlidingRuler

struct HorizontalStyleView: View {
    
    @ObservedObject var viewModel: ImagesViewModel
    
    @State private var rulerMargins: Double = 0
    
    @State private var margins: Double = 0
    
    @State private var showRuller = false
    
    private let merger: Merger
    
    init(viewModel: ImagesViewModel, merger: Merger) {
        self.viewModel = viewModel
        self.merger = merger
    }
    
    var body: some View {
        LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all).overlay(
                VStack{
                    let image = merger.merge(images: viewModel.images, columns: viewModel.images.count, spaceBetweenImages: CGFloat(margins)) ??
                        UIImage(imageLiteralResourceName: "topbg")
                    
                    let imageSaver = Saver()
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(alignment: .center){
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(nil, contentMode: .fit)
                            .frame(width:UIScreen.main.bounds.width * 1.5,
                                   height: UIScreen.main.bounds.height / 3)
                        }
                        .frame(width: UIScreen.main.bounds.width * 1.5)
                    }
                    
                    GeometryReader{geo in
                        VStack(alignment: .leading){
                            Spacer()
                            Toggle(isOn: $showRuller) {
                                Text("Margin").font(.title).foregroundColor(Color("Color")).multilineTextAlignment(.center).padding()
                            }.onChange(of: showRuller){ value in
                                if value == false{
                                    margins = 0
                                } else{
                                    margins = rulerMargins
                                }
                            }
                            .toggleStyle(SwitchToggleStyle(tint: Color("Color")))
                            .padding()
                            
                            if showRuller {
                                SlidingRuler(value: $rulerMargins,
                                             in: 0...1000,
                                             step: 20,
                                             onEditingChanged: {_ in margins = rulerMargins} ).padding() //adding proxy "margins" for rendering speed increase
                            }
                            
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    imageSaver.writeToPhotoAlbum(image: image)
                                }) {
                                    HStack(spacing: 6){
                                        Text("Join photos")
                                        Image("arrow").renderingMode(.original)
                                    }.foregroundColor(.white)
                                    .padding()
                                }.background(Color("Color"))
                                .cornerRadius(8)
                                Spacer()
                            }
                        }
                        
                    }
                    .clipShape(Rounded())
                    .padding(.top, -75)
                }
            )
    }
}


struct HorizontalStyleView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalStyleView(viewModel: ImagesViewModel(), merger: Merger())
    }
}
