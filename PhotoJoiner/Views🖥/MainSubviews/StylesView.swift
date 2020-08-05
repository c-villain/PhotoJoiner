//
//  StylesView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 04.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

struct StylesView: View {
    @ObservedObject var imagesViewModel: ImagesViewModel
    
    @State var showHoriz = false
    @State var showVert = false
    @State var showTable = false
    
    private let locator: ServiceLocator
    
    init(imagesViewModel: ImagesViewModel, locator: ServiceLocator){
        self.imagesViewModel = imagesViewModel
        self.locator = locator
    }

    var body: some View {
        VStack{
            Spacer()
            HStack{
                Button(action: {
                    showHoriz = true
                }) {
                    Image(systemName: "square.and.line.vertical.and.square")
                        .renderingMode(.none)
                        .foregroundColor(Color("Color"))
                        .font(.largeTitle)
                }.sheet(isPresented: $showHoriz){
                    HorizontalStyleView(viewModel: imagesViewModel, merger: locator.getService())
                }
                
                Spacer()
                
                Button(action: {
                    showVert = true
                }) {
                    Image(systemName: "text.justify")
                        .renderingMode(.none)
                        .foregroundColor(Color("Color"))
                        .font(.largeTitle)
                }.sheet(isPresented: $showVert){
                    VerticalStyleView(viewModel: imagesViewModel, merger: locator.getService())
                }
                
                Spacer()
                
                Button(action: {
                    showTable = true
                }) {
                    Image(systemName: "table")
                        .renderingMode(.none)
                        .foregroundColor(Color("Color"))
                        .font(.largeTitle)
                }.sheet(isPresented: $showTable){
                    TableStyleView()
                }
                
            } //HStack
        } //VStack
        .padding()
    }
}

struct StylesView_Previews: PreviewProvider {
    static var previews: some View {
        StylesView(imagesViewModel: ImagesViewModel(), locator: ServiceLocator())
    }
}
