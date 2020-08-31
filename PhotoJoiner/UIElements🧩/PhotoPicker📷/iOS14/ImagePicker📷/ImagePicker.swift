//
//  ImagePicker.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 31.07.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import PhotosUI

@available(iOS 14, *)
struct ImagePicker: UIViewControllerRepresentable {

    @ObservedObject var imagesViewModel: ImagesViewModel
    @Binding var pickerShowed: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images //show only photos not videos
        config.selectionLimit = 0 //0 - for multiple selection
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
}
