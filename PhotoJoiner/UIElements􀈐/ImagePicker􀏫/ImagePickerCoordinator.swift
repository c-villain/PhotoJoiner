//
//  ImagePickerCoordinator.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 31.07.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import PhotosUI

final class ImagePickerCoordinator: NSObject, PHPickerViewControllerDelegate {
    let imagePicker: ImagePicker

    init(_ imagePicker: ImagePicker) {
        self.imagePicker = imagePicker
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        imagePicker.pickerShowed.toggle()
        for img in results{
            if img.itemProvider.canLoadObject(ofClass: UIImage.self){
                img.itemProvider.loadObject(ofClass: UIImage.self){
                    (image, err) in
                    guard let image = image else {
                        print(err as Any)
                        return
                    }
                    DispatchQueue.main.async {
                    self.imagePicker.imagesViewModel.append(image as! UIImage)//.append(image as! UIImage)
                    }
                }
            }
            else{
                print("Can't load image")
            }
        }
    }
}
