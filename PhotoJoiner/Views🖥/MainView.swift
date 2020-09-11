//
//  MainView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 31.07.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import Photos
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
                            self.pickerShowed.toggle()
                        }) {
                            Image("Add")
                                .renderingMode(.template)
                                .foregroundColor(Color("Color"))
                        }//.frame(width: 72, height: 63).padding()
                        
                    }.sheet(isPresented: $pickerShowed) {
                        if #available(iOS 14.0, *) {
                            ImagePicker(imagesViewModel: imagesViewModel, pickerShowed: $pickerShowed)
                        }
                        else {
                            MultipleImagePickerSheet(pickerShowed: self.$pickerShowed,
                                doneAction: { (identifiers) in

                                    var arrayOfPHAsset : [PHAsset] = []
                                    
                                    let fetchAssets = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
                                    
                                    DispatchQueue.global(qos: .userInteractive).async {
                                        
                                        fetchAssets.enumerateObjects({(object: AnyObject!,
                                                    count: Int,
                                                    stop: UnsafeMutablePointer<ObjCBool>) in

                                                    if object is PHAsset{
                                                        let asset = object as! PHAsset
                                                        print(asset)
                                                        arrayOfPHAsset.append(asset)
                                                    }
                                                })
                                        
                                        let options = PHImageRequestOptions()
                                        options.isSynchronous = true

                                        for asset in arrayOfPHAsset{
                                            PHCachingImageManager.default().requestImage(for: asset, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                                                
                                                self.imagesViewModel.append(PhotoImage(image: image!, asset: asset))
                                            }
                                        }
                                    }
                                } //doneAction in MultipleImagePickerSheet
                            ) //MultipleImagePickerSheet
                        }
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let merger = Merger()
        let saver = Saver()
        return MainView().environmentObject(ImagesViewModel(merger: merger, saver: saver))
    }
}
