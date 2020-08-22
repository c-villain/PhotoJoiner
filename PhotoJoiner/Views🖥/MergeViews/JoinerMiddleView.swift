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
                if showRuller {
                    HStack{
                        Image("Columns")
                            .renderingMode(.template)
                            .foregroundColor(Color("Color"))
                        
                        SlidingRuler(value: $columns,
                                     in: 1...20,
                                     step: 1,
                                     onEditingChanged: {dragStarts in
                                        if(!dragStarts){
                                            self.viewModel.merge(columns: Int(columns), spaceBetweenImages: margin)
                                        }
                                     } ).padding()
                    }.padding()
                }
                
                HStack{
                    Image("Margin")
                        .renderingMode(.template)
                        .foregroundColor(Color("Color"))

                    SlidingRuler(value: $margin,
                                 in: 0...1000,
                                 step: 20,
                                 onEditingChanged: {dragStarts in
                                    if(!dragStarts){
                                        self.viewModel.merge(columns: Int(columns), spaceBetweenImages: margin)
                                    }
                                 } ).padding()
                }
                .padding()
                Spacer()
            }
        }
        .clipShape(Rounded())
        .padding(.top, -75)
    }
}

//struct JoinerMiddleView_Previews: PreviewProvider {
//    static var previews: some View {
//        JoinerMiddleView()
//    }
//}
