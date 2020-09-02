//
//  ImagesViewModel.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 02.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import Photos

final class ImagesViewModel: ObservableObject{
    
    @Published private(set) var images: [PhotoImage] = []
    
    @Published private(set) var mergedImage: UIImage = UIImage(imageLiteralResourceName: "photo")
    
    private let merger: MergerProtocol
    private let saver: SaverProtocol
    
    init(merger: MergerProtocol, saver: SaverProtocol) {
        self.merger = merger
        self.saver = saver
    }
    
    // MARK: - append operations (work with image collection)
    
    public func append(_ photoImage: PhotoImage){
        self.images.append(photoImage)
    }
    
    public func remove(_ image: UIImage){
        let index = self.index(of: image)
        guard index != nil else {
            print("No image found with this id!")
            return
        }
        self.images.remove(at: index!)
    }
    
    // MARK: - remove operations (work with image collection)
    
    public func remove(_ image: PhotoImage){
        let index = self.index(of: image)
        guard index != nil else {
            print("No image found with this id!")
            return
        }
        self.images.remove(at: index!)
    }
    
    public func remove(_ asset: PHAsset){
        let index = self.index(of: asset)
        guard index != nil else {
            print("No image found with this asset!")
            return
        }
        self.images.remove(at: index!)
    }
    
    // MARK: - finding operations (work with image collection)
    
    public func index(of asset: PHAsset) -> Int?{
        for index in 0..<self.images.count{
            if self.images[index].asset == asset{
                return index
            }
        }
        return .none
    }
    
    public func index(of img: UIImage) -> Int?{
        for index in 0..<self.images.count{
            if self.images[index].image == img{
                return index
            }
        }
        return .none
    }
    
    public func index(of: PhotoImage) -> Int?{
        for index in 0..<self.images.count{
            if self.images[index].id == of.id{
                return index
            }
        }
        return .none
    }
    
    // MARK: - func for carousel
    public func setImageOffset(at index: Int, offset: CGFloat){
        guard self.images.count > index else {return}
        self.images[index].offset = offset
    }

    public func changeImageOffset(at index: Int, offset: CGFloat){
        guard self.images.count > index else {return}
        self.images[index].offset += offset
    }
 
    // MARK: - shuffling
    public func shuffle(){
        guard self.images.count > 0 else {return}
        
        let offsets = self.images.map{$0.offset} //currents offsets of images before shuffling
        self.images.shuffle()
        for i in 0..<self.images.count {
            self.images[i].offset = offsets[i]
        }
    }
    
    //MARK: - merging
    public func merge(columns: Int, spaceBetweenImages: Double){
        self.mergedImage = self.merger.merge(images: self.images, columns: columns, spaceBetweenImages: CGFloat(spaceBetweenImages)) ?? UIImage(imageLiteralResourceName: "photo")
    }
    
    //MARK: - saving
//    public func saveMergedImage(completionSelector: Selector){
//        self.saver.writeToPhotoAlbum(image: self.mergedImage, completionTarget: self.saver, completionSelector: completionSelector)
//    }
    
    public func saveMergedImage(){
        self.saver.writeToPhotoAlbum(image: self.mergedImage)
    }
    
    //MARK: - adapting asset to uiimage
    
    private func getUIImages(assets: [PHAsset])-> [UIImage]{
        var array = [UIImage]()
        for asset in assets {
            guard let img = self.getUIImage(asset: asset) else {continue}
            array.append(img)
        }
        return array
    }
    
    private func getUIImage(asset: PHAsset) -> UIImage? {

        var img: UIImage?
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.version = .original
        options.isSynchronous = true
        manager.requestImageDataAndOrientation(for: asset, options: options){ data, _, _, _ in
            if let data = data {
                img = UIImage(data: data)
            }
        }
        return img
    }
}
