//
//  StylesView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 04.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

struct StyleSelectionView: View {
    @ObservedObject var imagesViewModel: ImagesViewModel
    
    @State var showHoriz = false
    @State var showVert = false
    @State var showTable = false
    
    init(imagesViewModel: ImagesViewModel){
        self.imagesViewModel = imagesViewModel
    }

    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    showHoriz = true
                }) {
                    Image("Horiz")
                        .renderingMode(.template)
                        .foregroundColor(Color("Color"))
                }
                .buttonStyle(PlainButtonStyle())
//                .frame(width: 114, height: 65)
                .sheet(isPresented: $showHoriz){
                    JoinerView(style: .horizontal,
                               viewModel: imagesViewModel)
                }
                
                Spacer()
                
                Button(action: {
                    showVert = true
                }) {
                    Image("Vert")
                        .renderingMode(.template)
                        .foregroundColor(Color("Color"))
                }
//                .frame(width: 137, height: 114)
                .sheet(isPresented: $showVert){
                    JoinerView(style: .vertical,
                               viewModel: imagesViewModel)
                }
                
                Spacer()
                
                Button(action: {
                    showTable = true
                }) {
                    Image("Table")
                        .renderingMode(.template)
                        .foregroundColor(Color("Color"))
                }
//                .frame(width: 137, height: 114)
                .sheet(isPresented: $showTable){
                    JoinerView(style: .table,
                               viewModel: imagesViewModel)
                }
            } //HStack
        } //VStack
        .padding()
    }
}

struct StylesView_Previews: PreviewProvider {
    static var previews: some View {
        StyleSelectionView(imagesViewModel: ImagesViewModel(merger: Merger(), saver: Saver()))
    }
}
