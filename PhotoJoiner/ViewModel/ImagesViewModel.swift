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
        self.images[index].offset = offset
    }

    public func changeImageOffset(at index: Int, offset: CGFloat){
        self.images[index].offset += offset
    }
    
    // MARK: - size of merging photos
    
//    func getSizeOfHorizMerging(spaceBetweenImages:CGFloat = 0)-> CGSize{
//
//        guard !images.isEmpty else {return CGSize(width: 0, height: 0)} //if array is empty size is zero
//
//        var fullWidth: CGFloat = 0
//        var maxHeight: CGFloat = images[0].size.height
//
//        for index in 0..<images.count {
//            fullWidth += images[index].size.width
//            if (index+1 < images.count) {
//                fullWidth += spaceBetweenImages
//            }
//            if (maxHeight < images[index].size.height) {
//                maxHeight = images[index].size.height
//            }
//        }
//        return CGSize(width: fullWidth, height: maxHeight)
//    }
    
    // MARK: - merging photos
    
//    public func mergeHorizontPhotos(spaceBetweenImages:CGFloat = 0) -> UIImage?{
//        
//        guard !images.isEmpty else {return nil} //if array is empty nothing to merge
//        
//        let size = getSizeOfHorizMerging(spaceBetweenImages: spaceBetweenImages)
//        
//        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//        
//        for index in 0..<images.count {
//
//            var imageX: CGFloat = 0
//            for inx in 0..<index {
//                imageX += images[inx].size.width
//                if (inx+1 < images.count) {
//                    imageX += spaceBetweenImages
//                }
//            }
//            let imageY:CGFloat = (size.height - images[index].size.height)
//            let rect = CGRect(x: imageX, y: imageY, width: images[index].size.width, height: images[index].size.height)
//            
//            context.draw(images[index].cgImage, in: rect)
//        }
//     
//        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//    }
//    
//    
//    func combine(images: [ImageToCombine], spaceBetweenImages:CGFloat) -> UIImage {
//
//        var fullWidth:CGFloat = 0
//        var minHeight:CGFloat = images[0].size.height
//
//        for index in 0..<images.count {
//            fullWidth += images[index].size.width
//            if (index+1 < images.count) {
//                fullWidth += spaceBetweenImages
//            }
//            if (minHeight > images[index].size.height) {
//                minHeight = images[index].size.height
//            }
//        }
//
//        let quality = CGFloat(4)
//        let boundForBetter = CGRectMake(0, 0, fullWidth*quality, minHeight*quality)
//
//        UIGraphicsBeginImageContext(boundForBetter.size)
//        let context = UIGraphicsGetCurrentContext()
//
//        for index in 0..<images.count {
//
//            var imageX:CGFloat = 0
//            for index2 in 0..<index {
//                imageX += images[index2].size.width
//
//                if (index2+1 < images.count) {
//                    imageX += spaceBetweenImages
//                }
//            }
//            let imageY:CGFloat = (minHeight - images[index].size.height)*quality/2
//            let rect = CGRect(x: imageX*quality, y: imageY, width: images[index].size.width*quality, height: images[index].size.height*quality)
//            CGContextDrawImage(context, rect, images[index].image.CGImage)
//        }
//
//        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        let resultImageimage = UIImage(CGImage: imageResize(combinedImage, sizeChange:CGSize(width: fullWidth/quality, height: minHeight/quality)).CGImage!, scale: 1.0, orientation: .DownMirrored)
//
//        return resultImageimage
//    }
//    
}
