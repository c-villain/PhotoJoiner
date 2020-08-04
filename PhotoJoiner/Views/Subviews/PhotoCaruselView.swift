//
//  PhotoCaruselView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 04.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

struct PhotoCaruselView: View{
    @ObservedObject var imagesVM: ImagesViewModel
    @State var scrolled = 0

    var body: some View {
        // Zstack Will Overlap Views So Last WIll Become First...
        ZStack{
            ForEach(imagesVM.images.reversed()){photo in
                
                let curPhotoIndex = imagesVM.index(of: photo)!
                let lastPhotoIndex = imagesVM.index(of: imagesVM.images.last!)!
                
                HStack{
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
                        Image(uiImage: photo.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            // dynamic frame....
                            // dynamic height...
                            .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 2.5) - CGFloat(curPhotoIndex - scrolled) * 50)
                            .cornerRadius(15)
                            // based on scrolled changing view size...
                        
                        VStack(alignment: .leading,spacing: 18){
                            
                            Button(action: {
                                withAnimation(.easeIn(duration: 0.4)){
                                    //restoring previous photo
                                    if scrolled > 0 {
                                        imagesVM.changeImageOffset(at: curPhotoIndex - 1, offset:  (calculateWidth() + 60))
                                        scrolled -= 1
                                    }
                                    imagesVM.remove(photo)
                                }
                            }) {
                                Spacer()
                                Image(systemName: "trash.fill")
                                    .renderingMode(.none)
                                    .foregroundColor(Color("Color"))
                                    .font(.title3)
                            }
                        }
                        .frame(width: calculateWidth() - 40)
                        .padding(.leading,20)
                        .padding(.bottom,20)

                    } //ZStack
                    .offset(x: curPhotoIndex - scrolled <= 2 ? CGFloat(curPhotoIndex - scrolled) * 30 : 60)
                } //HStack
                .contentShape(Rectangle())
                // adding gesture...
                .offset(x: photo.offset)
                .gesture(DragGesture().onChanged({ (value) in
                    withAnimation{
                        // disabling drag for last photo...
                        if value.translation.width < 0 {
                            if curPhotoIndex != lastPhotoIndex{
                                imagesVM.setImageOffset(at: curPhotoIndex, offset: value.translation.width)
                            }
                        }
                        else{
                            // restoring photos...
                            if imagesVM.index(of: photo)! > 0{
                                imagesVM.setImageOffset(at: curPhotoIndex - 1, offset: -(calculateWidth() + 60) + value.translation.width)
                            }
                        }
                    }
                })
                .onEnded({ (value) in
                    withAnimation{
                        if value.translation.width < 0{
                            if -value.translation.width > 180 && curPhotoIndex != lastPhotoIndex{
                                // moving view away...
                                imagesVM.setImageOffset(at: curPhotoIndex, offset: -(calculateWidth() + 60))
                                scrolled += 1
                            }
                            else{
                                imagesVM.setImageOffset(at: curPhotoIndex, offset: 0)
                            }
                        }
                        else{
                            // restoring photo:
                            if imagesVM.index(of: photo)! > 0{
                                if value.translation.width > 180{
                                    imagesVM.setImageOffset(at: curPhotoIndex - 1, offset: 0)
                                    scrolled -= 1
                                }
                                else{
                                    imagesVM.setImageOffset(at: curPhotoIndex - 1, offset: -(calculateWidth() + 60))
                                }
                            }
                        }
                    }
                })
                ) //DragGesture
            } //ForEach
        } //ZStack
        .frame(height: UIScreen.main.bounds.height / 2.5)
    } //some View
    
    func calculateWidth()->CGFloat{
        
        // horizontal padding 30
        let screen = UIScreen.main.bounds.width - 30
        
        // going to show first three photos
        // all other will be hidden....
        // scnd and third will be moved x axis with 30 value..
        let width = screen - (2 * 30)
        
        return width
    }
}

//struct PhotoCaruselView_Previews: PreviewProvider {
//    static var previews: some View {
//        PhotoCaruselView()
//    }
//}
