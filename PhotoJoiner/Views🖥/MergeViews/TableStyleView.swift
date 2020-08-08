//
//  TableStyleView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 03.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import SlidingRuler
import PopupView


struct TableStyleView: View {
    
    @ObservedObject var viewModel: ImagesViewModel
    
    @State private var columns: Int = 2
    @State private var rulerColumns: Double = 2 //proxy for speed rendering
    
    @State private var rulerMargins: Double = 0 //proxy for speed rendering
    
    @State private var margins: Double = 0
    
    @State private var showRuller = false
    @State private var showingTopPopup = false
    
    private let merger: Merger
    
    init(viewModel: ImagesViewModel, merger: Merger) {
        self.viewModel = viewModel
        self.merger = merger
    }
    
    var body: some View {
        LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all).overlay(
                ZStack{
                    VStack{
                    let image = merger.merge(images: viewModel.images, columns: columns, spaceBetweenImages: CGFloat(margins)) ??
                        UIImage(imageLiteralResourceName: "topbg")
                    
                    let imageSaver = Saver()

                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(nil, contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width - 30,
                               height:UIScreen.main.bounds.height / 2.5,
                               alignment: .center )
                    
                    GeometryReader{geo in
                        VStack(alignment: .leading){
                            Spacer()
                            HStack{
                                Text("Columns").font(.title).foregroundColor(Color("Color")).multilineTextAlignment(.center).padding()
                                SlidingRuler(value: $rulerColumns,
                                             in: 1...20,
                                             step: 1,
                                             onEditingChanged: {_ in columns = Int(rulerColumns)} ).padding()
                            }
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
                                    withAnimation{
                                        self.viewModel.shuffle()
                                    }
                                }) {
                                    HStack(spacing: 6){
                                        Text("Shuffle")
                                    }.foregroundColor(.white)
                                    .padding()
                                }.background(Color("Color"))
                                .cornerRadius(8)
                                
                                Spacer()
                                Button(action: {
                                    imageSaver.writeToPhotoAlbum(image: image)
                                    showingTopPopup = true
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
                }.popup(isPresented: $showingTopPopup, type: .floater(), position: .top, animation: Animation.spring(), autohideIn: 1) {
                    HStack {
                        Text("Saved")
                    }.foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width, height: 60)
                    .background(Color("Color"))
                    .cornerRadius(8.0)
                }
            )
    }
}

struct TableStyleView_Previews: PreviewProvider {
    static var previews: some View {
        TableStyleView(viewModel: ImagesViewModel(), merger: Merger())
    }
}
