//
//  JoinerView.swift
//  JoinerView
//
//  Created by Alexander Kraev on 08.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import SlidingRuler
import PopupView

struct JoinerView: View {
    //for showing popup view to notify about exporting
    @State private var showingTopPopup = false
    
    @ObservedObject var viewModel: ImagesViewModel
    
    @State private var columns: Double = 1
    @State private var margin: Double = 0
    @State private var showRuller = false

    private let style: Style
    
    init(style: Style, viewModel: ImagesViewModel) {
        self.style = style
        self.viewModel = viewModel
//        switch self.style{
//            case .horizontal:
//                columns = Double(self.viewModel.images.count)
//            case .vertical:
//                columns = 1
//            case .table:
//                self.showRuller = true
//                columns = 2
//        }
    }
    
    var body: some View {
        LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all).overlay(
                ZStack{
                    VStack{
                        Image(uiImage: self.viewModel.mergedImage)
                            .resizable()
                            .aspectRatio(nil, contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width - 30,
                                   height:UIScreen.main.bounds.height / 2.5,
                                   alignment: .center )

                    
                        JoinerMiddleView(viewModel: self.viewModel,
                                         showRuller: self.$showRuller,
                                         columns: self.$columns,
                                         margin: self.$margin)
                        
                        JoinerBottomView(viewModel: self.viewModel,
                                         shuffleTapped: { (finishedShuffling) in
                                            if (finishedShuffling){
                                                self.viewModel.merge(columns: Int(columns), spaceBetweenImages: margin)
                                            }
                                         },
                                         savingTapped: {
                                            self.showingTopPopup = true }
                        )
                    }
                    .onAppear(perform: {
                        switch self.style{
                            case .horizontal:
                                columns = Double(self.viewModel.images.count)
                            case .vertical:
                                columns = 1
                            case .table:
                                self.showRuller = true
                                columns = 2
                        }
                        self.viewModel.merge(columns: Int(columns), spaceBetweenImages: margin)
                    })
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

//struct JoinerView_Previews: PreviewProvider {
//    static var previews: some View {
//        JoinerView()
//    }
//}
