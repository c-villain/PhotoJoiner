//
//  ImagesViewModel.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 02.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

final class ImagesViewModel: ObservableObject{
    
    @Published private(set) var images: [PhotoImage] = []
    
    @Published private(set) var mergedImage: UIImage = UIImage(imageLiteralResourceName: "photo")
    
    private let merger: MergerProtocol
    private let saver: SaverProtocol
    
    init(merger: MergerProtocol, saver: SaverProtocol) {
        self.merger = merger
        self.saver = saver
    }
    
    // MARK: - basic operations (work with image collection)
    public func append(_ images: UIImage...){
        for img in images{
            self.images.append(PhotoImage(image: img, offset: 0))
        }
    }
    
    public func remove(_ image: PhotoImage){
        let index = self.index(of: image)
        guard index != nil else {
            print("No image found with this id!")
            return
        }
        self.images.remove(at: index!)
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
        self.images.shuffle()
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
}
