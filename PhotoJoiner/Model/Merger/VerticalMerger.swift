//
//  VerticalMerger.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 05.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//


import SwiftUI

class VerticalMerger: ImageMergerProtocol{
    
    func getMergedSize(images: [PhotoImage], spaceBetweenImages:CGFloat) -> CGSize{
        guard !images.isEmpty else {return CGSize(width: 0, height: 0)} //if array is empty size is zero

        var maxWidth: CGFloat =  images[0].image.size.width
        var fullHeight: CGFloat = 0

        for index in 0..<images.count {
            fullHeight += images[index].image.size.height
            if (index+1 < images.count) {
                fullHeight += spaceBetweenImages
            }
            if (maxWidth < images[index].image.size.width) {
                maxWidth = images[index].image.size.width
            }
        }
        return CGSize(width: maxWidth, height: fullHeight)
    }
    
    func merge(images: [PhotoImage], spaceBetweenImages: CGFloat) -> UIImage? {
        guard !images.isEmpty else {return nil} //if array is empty nothing to merge
        
        let size = getMergedSize(images: images, spaceBetweenImages: spaceBetweenImages)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        let count = images.count
        
        for index in 0..<images.count {
            var imageY: CGFloat = 0
            for inx in 0..<index {
                imageY += images[count - 1 - inx].image.size.height
                if (count - 2 - inx < images.count) {
                    imageY += spaceBetweenImages
                }
            }
            let rect = CGRect(x: 0, //always from left corner
                              y: imageY,
                              width: images[count - 1 - index].image.size.width,
                              height: images[count - 1 - index].image.size.height)

            context?.draw(images[count - 1 - index].image.cgImage!, in: rect)
        }
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let resultImageimage = UIImage(cgImage: (combinedImage?.cgImage)!, scale: 1.0, orientation: .downMirrored)
        
        return resultImageimage
    }

}

