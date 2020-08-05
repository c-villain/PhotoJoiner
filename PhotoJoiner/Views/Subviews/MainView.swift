//
//  MainView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 31.07.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

struct MainView : View {
    
    @State private var pickerShowed = false
    @EnvironmentObject var imagesViewModel: ImagesViewModel
    @EnvironmentObject var serviceLocator: ServiceLocator
    
    var body: some View {
//        LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
//            .edgesIgnoringSafeArea(.all).overlay(
        ZStack{
            
            LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(alignment: .leading, spacing: 12){
                        HStack{
                            Button(action: {
                                self.pickerShowed = true
                            }) {
                                Image(systemName: "photo.on.rectangle")
                                    .renderingMode(.none)
                                    .foregroundColor(Color("Color"))
                                    .font(.title3)
                            }
                            Spacer()
                        }.sheet(isPresented: $pickerShowed) {
                            ImagePicker(imagesViewModel: imagesViewModel, pickerShowed: $pickerShowed)
                        }
                        PhotoCaruselView(imagesVM: self.imagesViewModel)
                        
                        StylesView(imagesViewModel: self.imagesViewModel, locator: serviceLocator)
                    } //VStack
                    .padding()
                }//ScrollView
//            )//overlay
        } //ZStack
    }//View
} //ContentView

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(imagesViewModel: ImagesViewModel(), styleType: 0)
//    }
//}
