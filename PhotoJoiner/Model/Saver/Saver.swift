//
//  Saver.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 05.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import PhotosUI

class Saver: SaverProtocol, ObservableObject {
    
//    private var notificationCenter: NotificationCenter
//
//    init(center: NotificationCenter = .default) {
//            notificationCenter = center
//            notificationCenter.addObserver(self, selector: #selector(saveError), name: UIResponder.keyboardWillShowNotification, object: nil)
//        }
//
//    deinit {
//        notificationCenter.removeObserver(self)
//    }
    
//    func writeToPhotoAlbum(image: UIImage, completionTarget: Any, completionSelector: Selector) {
////        UIImageWriteToSavedPhotosAlbum(image, completionTarget, #selector(saveError), nil)
//        UIImageWriteToSavedPhotosAlbum(image, completionTarget, completionSelector, nil)
//    }

    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
//
//    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        if error == nil {
//        print("Save finished!")
//        }
//        else{
//            print("Save error: \(String(describing: error?.localizedDescription))")
//        }
//    }
}
