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
    
    public func setImageOffset(at index: Int, offset: CGFloat){
        guard self.images.count > index else {return}
        self.images[index].offset = offset
    }

    public func changeImageOffset(at index: Int, offset: CGFloat){
        guard self.images.count > index else {return}
        self.images[index].offset += offset
    }
}
