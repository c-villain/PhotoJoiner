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
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            Image("photojoiner")
                .renderingMode(.template)
                .foregroundColor(Color("Color"))
                .opacity(0.08)
                .padding(.top, -(UIScreen.main.bounds.height / 4))
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading){
                    Spacer()
                    HStack(alignment: .center){
                        Button(action: {
                            self.pickerShowed = true
                        }) {
                            Image("Add")
                                .renderingMode(.template)
                                .foregroundColor(Color("Color"))
                        }
                        
                    }.sheet(isPresented: $pickerShowed) {
                        ImagePicker(imagesViewModel: imagesViewModel, pickerShowed: $pickerShowed)
                    }
                    .padding(.leading)
                    
                    PhotoCaruselView(imagesVM: self.imagesViewModel)
                    
                    StyleSelectionView(imagesViewModel: self.imagesViewModel)
                        .offset(y: 50)
                    } //VStack
                }//ScrollView
        } //ZStack
    }//View
} //ContentView

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
