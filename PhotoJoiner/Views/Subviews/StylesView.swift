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
    
    @State var show = false

    @State var selectedStyle = Styles.horizontal
    
    var body: some View {
        VStack{
            Spacer()
            HStack{
                Button(action: {
                    selectedStyle = .horizontal
                    show.toggle()
                    
                }) {
                    Image(systemName: "square.and.line.vertical.and.square")
                        .renderingMode(.none)
                        .foregroundColor(Color("Color"))
                        .font(.largeTitle)
                }
                
                Spacer()
                
                Button(action: {
                    selectedStyle = .vertical
                    show.toggle()
                }) {
                    Image(systemName: "text.justify")
                        .renderingMode(.none)
                        .foregroundColor(Color("Color"))
                        .font(.largeTitle)
                }
                
                Spacer()
                
                Button(action: {
                    selectedStyle = .table
                    show.toggle()
                }) {
                    Image(systemName: "table")
                        .renderingMode(.none)
                        .foregroundColor(Color("Color"))
                        .font(.largeTitle)
                }
            } //HStack
        } //VStack
        .padding()
        .sheet(isPresented: $show) {
            switch selectedStyle {
            case .horizontal:
                HorizontalStyleView(viewModel: self.imagesViewModel)
            case .vertical:
                VerticalStyleView()
            case .table:
                TableStyleView()
            }
        }
    }
}

struct StylesView_Previews: PreviewProvider {
    static var previews: some View {
        StylesView(imagesViewModel: ImagesViewModel(), selectedStyle: .horizontal)
    }
}
