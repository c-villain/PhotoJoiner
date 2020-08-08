//
//  Merger.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 06.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

class Merger: MergerProtocol, ObservableObject{
    func getMergedSize(images: [[PhotoImage]], spaceBetweenImages: CGFloat) -> CGSize{
        //if array is empty size is zero:
        guard !images.isEmpty else {return CGSize(width: 0, height: 0)}
        
        var fullWidth: CGFloat = 0
        var fullHeight: CGFloat = 0

        for x in 0..<images.count{
            
            var rowWidth: CGFloat = 0
            var rowHeight: CGFloat = 0
            for y in 0..<images[x].count{
                //looking for the tallest picture in the row:
                if (rowHeight < images[x][y].image.size.height) {
                    rowHeight = images[x][y].image.size.height
                }
                
                rowWidth += images[x][y].image.size.width
                rowWidth += spaceBetweenImages
            }
            //try to find max row width: row by row,
            //if previous row width < current row width,
            //then increase total width:
            if (fullWidth < rowWidth) {
                fullWidth = rowWidth
            }
            //after compare
            //set width for next row to 0:
            rowWidth = 0
            
            //the same with heigth
            //current row heigth addding to final height:
            fullHeight += rowHeight
            
            //adding between rows spaces:
            fullHeight += spaceBetweenImages
            //after that set height for next row to 0:
            rowHeight = 0
        }

        return CGSize(width: fullWidth + spaceBetweenImages, height: fullHeight + spaceBetweenImages)
    }
    
    func merge(images: [PhotoImage], columns: Int, spaceBetweenImages: CGFloat) -> UIImage? {
        //if array is empty nothing to merge:
        guard !images.isEmpty else {return nil}
        
        //split ro array of photos for each row depend on number of columns
        let splittedImages: [[PhotoImage]] = images.split(into: columns).reversed()

        //get final size of merged collage:
        let size = getMergedSize(images: splittedImages, spaceBetweenImages: spaceBetweenImages)
        
        //rect for future mergered image:
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        //Creates a bitmap-based graphics context and makes it the current context:
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
  
        // (x,y) - coordinate for  next picture
        //start coordinates
        var imgX: CGFloat = spaceBetweenImages
        var imgY: CGFloat = spaceBetweenImages
        
        for x in 0..<splittedImages.count{
            var nextYRow: CGFloat = 0

            //finding the height of currentrow:
            for y in 0..<splittedImages[x].count{
                if (nextYRow < splittedImages[x][y].image.size.height) {
                    nextYRow = splittedImages[x][y].image.size.height
                }
            }
            
            for y in 0..<splittedImages[x].count{
                
                let rect = CGRect(x: imgX,
                                  y: imgY + nextYRow - splittedImages[x][y].image.size.height,
                                  width: splittedImages[x][y].image.size.width,
                                  height: splittedImages[x][y].image.size.height)

                //inrease x-coord for next picure in row:
                imgX += splittedImages[x][y].image.size.width
                if (y != splittedImages[x].count) {
                    imgX += spaceBetweenImages
                }

                context?.draw(splittedImages[x][y].image.cgImage!, in: rect)
            }
            //update coordinates for next row:
            //zero x-coord
            imgY += nextYRow + spaceBetweenImages
            nextYRow = 0

            imgX = spaceBetweenImages
        }
        
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let resultImage = UIImage(cgImage: (combinedImage?.cgImage)!, scale: 1.0, orientation: .downMirrored)
        
        return resultImage
    }
}
