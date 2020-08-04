//
//  ImageSaver.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 05.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import PhotosUI

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
}
