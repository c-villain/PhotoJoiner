//
//  PhotoImage.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 03.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI
import Photos

public struct PhotoImage : Identifiable {
    public var id = UUID()
    public var image : UIImage
    public var asset : PHAsset
    public var offset : CGFloat
    
    init(image : UIImage){
        self.init(image: image, asset: PHAsset(), offset: 0)
    }
    
    init(image : UIImage, asset : PHAsset, offset : CGFloat = 0) {
        self.image = image
        self.asset = asset
        self.offset = offset
    }
}
