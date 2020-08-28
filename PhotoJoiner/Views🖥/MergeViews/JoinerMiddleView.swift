//
//  JoinerMiddleView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 13.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import SlidingRuler


struct JoinerMiddleView: View {
    
    @ObservedObject var viewModel: ImagesViewModel
    
    @Binding var showRuller: Bool
    @Binding var columns: Double
    @Binding var margin: Double
    
    var body: some View {
        GeometryReader{geo in
            VStack(alignment: .leading){
                Spacer()
                HStack{
                    VStack(alignment: .leading){
                        if showRuller {
                            Image("Columns")
                                .renderingMode(.template)
                                .foregroundColor(Color("Color")).frame(maxHeight: .infinity).padding()
                        }
                        Image("Margin")
                            .renderingMode(.template)
                            .foregroundColor(Color("Color")).frame(maxHeight: .infinity).padding()
                    }.frame(height: 184)
                    VStack(alignment: .center){
                        if showRuller {
                            CustomStepper(value: $columns,
                                          onEditingChanged:{_ in
                                            DispatchQueue.main.async {
                                                self.viewModel.merge(columns: Int(columns), spaceBetweenImages: margin)
                                            }
                                          }).frame(height: 88, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }
                        SlidingRuler(value: $margin,
                                     in: 0...1000,
                                     step: 20,
                                     onEditingChanged: {dragStarts in
                                        if(!dragStarts){
                                            self.viewModel.merge(columns: Int(columns), spaceBetweenImages: margin)
                                        }
                                     } ).frame(height: 88, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.frame(height: 184)
                }.fixedSize(horizontal: false, vertical: true).padding()
                Spacer()
            }
        }
        .clipShape(Rounded())
        .padding(.top, -75)
    }
}

struct JoinerMiddleView_Previews: PreviewProvider {
    static var previews: some View {
        let merger = Merger()
        let saver = Saver()
        return JoinerMiddleView(viewModel: ImagesViewModel(merger: merger,
                                                    saver: saver),
                         showRuller: .constant(true),
                         columns: .constant(3),
                         margin: .constant(140))
    }
}
