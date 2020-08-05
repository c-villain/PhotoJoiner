//
//  HorizontalMerger.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 05.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

class HorizontalMerger: MergerProtocol{
    
    func getMergedSize(images: [PhotoImage], spaceBetweenImages:CGFloat) -> CGSize{

        guard !images.isEmpty else {return CGSize(width: 0, height: 0)} //if array is empty size is zero

        var fullWidth: CGFloat = 0
        var maxHeight: CGFloat = images[0].image.size.height

        for index in 0..<images.count {
            fullWidth += images[index].image.size.width
            if (index+1 < images.count) {
                fullWidth += spaceBetweenImages
            }
            if (maxHeight < images[index].image.size.height) {
                maxHeight = images[index].image.size.height
            }
        }
        return CGSize(width: fullWidth, height: maxHeight)
    }
    
    func mergePhotos(images: [PhotoImage], spaceBetweenImages: CGFloat) -> UIImage? {
        guard !images.isEmpty else {return nil} //if array is empty nothing to merge
        
        let size = getMergedSize(images: images, spaceBetweenImages: spaceBetweenImages)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        for index in 0..<images.count {

            var imageX: CGFloat = 0
            for inx in 0..<index {
                imageX += images[inx].image.size.width
                if (inx+1 < images.count) {
                    imageX += spaceBetweenImages
                }
            }
            let imageY:CGFloat = (size.height - images[index].image.size.height)
            let rect = CGRect(x: imageX, y: imageY, width: images[index].image.size.width, height: images[index].image.size.height)
            
            context?.draw(images[index].image.cgImage!, in: rect)
        }
     
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let resultImageimage = UIImage(cgImage: (combinedImage?.cgImage)!, scale: 1.0, orientation: .downMirrored)
        
        return resultImageimage
    }
    
    
}
