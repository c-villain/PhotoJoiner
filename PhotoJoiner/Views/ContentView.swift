//
//  ContentView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 31.07.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    
    @State private var pickerShowed = false
    @ObservedObject var imagesViewModel: ImagesViewModel
    
    var body: some View {
        LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all).overlay(
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
                        
                        StylesView(imagesViewModel: self.imagesViewModel)
                    } //VStack
                    .padding()
                }//ScrollView
            )//overlay
    }//View
} //ContentView


//struct ContentView: View {
//
//    @State private var pickerShowed = false
//    @ObservedObject var imagesViewModel: ImagesViewModel
//    @State private var showBottomSheet = false
////    @State var draftProfile = Profile.default
//    @State private var styleType: Int = 0
//
//    var body: some View {
//        NavigationView {
//            VStack{
//                if !imagesViewModel.images.isEmpty{
//                    ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, content: {
//                        ForEach(imagesViewModel.images, id: \.self){img in
//                            Image(uiImage: img).resizable().frame(width: UIScreen.main.bounds.width - 45, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).cornerRadius(10)
//                        }
//                    })
//                }
//                BottomSheetModal(display: $showBottomSheet) {
//                    Picker("Style", selection: $styleType) {
//                        Text("H").tag(0)
//                        Text("V").tag(1)
//                        Text("Table").tag(2)
//                                    }
//                                    .pickerStyle(SegmentedPickerStyle())
//                      }
//            } //VStack
//
//            .navigationBarItems(
//                leading:
//                    HStack{
//                        Button(action: {
//                            //saving to library:
////                            UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)
//                        }){
//                            Image(systemName: "arrow.down.square")
//                        }
//                    }
//                ,trailing:
//                    HStack{
//                        Button(action: {
//                            self.pickerShowed = true
//                        }){
//                            Image(systemName: "photo.on.rectangle")
//                        }
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Button(action: {
//                            withAnimation {
//                                self.showBottomSheet.toggle()
//                            }
//                        }){
//                            Image(systemName: "slider.horizontal.3")
//                        }
//                    }
//            )
//        }//NavigationView
//        .sheet(isPresented: $pickerShowed) {
//            ImagePicker(imagesViewModel: imagesViewModel, pickerShowed: $pickerShowed)
//        }
//        .background(
//            LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
//                .edgesIgnoringSafeArea(.all)
//        )
//    } //some View
//
//} //View

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(imagesViewModel: ImagesViewModel(), styleType: 0)
//    }
//}
