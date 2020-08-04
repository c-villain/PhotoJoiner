//
//  HorizontalStyleView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 03.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import SlidingRuler

struct HorizontalStyleView: View {
    
    @ObservedObject var viewModel: ImagesViewModel
    
    @State private var spaceValue: Double = 0
    
    var body: some View {
        LinearGradient(gradient: .init(colors: [Color("Top"),Color("Bottom")]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all).overlay(
                VStack{
                    let image = viewModel.mergeHorizontPhotos(spaceBetweenImages: CGFloat(spaceValue)) ?? UIImage(imageLiteralResourceName: "topbg")
                    
                    let imageSaver = ImageSaver()
                       
                    ScrollView(.horizontal, showsIndicators: false){
                        Image(uiImage: image).resizable().aspectRatio(nil, contentMode: .fill).frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height / 4)
                    }
                    GeometryReader{geo in
                        VStack(alignment: .leading){
                            Spacer()
                            SlidingRuler(value: $spaceValue,
                                         in: 0...300).padding()
                            Spacer()
                            HStack{
                                Spacer()
                                Button(action: {
                                    imageSaver.writeToPhotoAlbum(image: image)
                                }) {
                                    HStack(spacing: 6){
                                        Text("Export")
                                        Image("arrow").renderingMode(.original)
                                    }.foregroundColor(.white)
                                    .padding()
                                }.background(Color("Color"))
                                .cornerRadius(8)
                                Spacer()
                            }
                            
                        }
                        
                    }
                    .clipShape(Rounded())
                    .padding(.top, -75)
                }
            )
    }
}

struct Rounded : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 40, height: 40))
        return Path(path.cgPath)
    }
}


struct HorizontalStyleView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalStyleView(viewModel: ImagesViewModel())
    }
}
