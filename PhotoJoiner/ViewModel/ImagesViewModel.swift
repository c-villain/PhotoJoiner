//
//  ImagesViewModel.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 02.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

final class ImagesViewModel: ObservableObject{
    @Published private(set) var images: [UIImage] = []
    
    public func append(_ images: UIImage...){
        self.images.append(contentsOf: images)
    }
    
    public func remove(_ image: UIImage){
        let index = self.index(of: image)
        guard index != nil else {
            print("No image found with this id!")
            return
        }
        self.images.remove(at: index!)
    }
    
    func index(of: UIImage) -> Int?{
        for index in 0..<self.images.count{
            if self.images[index].id == of.id{
                return index
            }
        }
        return .none
    }
}
