//
//  ImageMerger.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 04.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import Foundation

//class MergeImage{
//func mergeTextAndImage(image:UIImage, withLabel label: UILabel, outputSize:CGSize) -> UIImage? {
//        let inputSize:CGSize = image.size
//        let scale = max(outputSize.width / inputSize.width, outputSize.height / inputSize.height)
//        let scaledSize = CGSize(width: inputSize.width * scale, height: inputSize.height * scale)
//        let center = CGPoint(x: outputSize.width / 2, y: outputSize.height / 2)
//        let outputRect = CGRect(x: center.x - scaledSize.width/2, y: center.y - scaledSize.height/2, width: scaledSize.width, height: scaledSize.height)
//
//        UIGraphicsBeginImageContextWithOptions(outputSize, true, 0.0)
//
//        let context:CGContext = UIGraphicsGetCurrentContext()!
//        context.interpolationQuality = CGInterpolationQuality.high
//        image.draw(in: outputRect)
//
//        if let text = label.text {
//            if text.count > 0 {
//                var range:NSRange? = NSMakeRange(0, text.count)
//                let drawPoint = CGPoint(
//                    x: label.frame.origin.x / label.superview!.frame.width * outputSize.width,
//                    y: label.frame.origin.y / label.superview!.frame.height * outputSize.height)
//                let originalFont = label.font
//
//                label.font = UIFont(name: label.font!.fontName, size: label.font!.pointSize / label.superview!.frame.width * outputSize.width)
//                let attributes = label.attributedText?.attributes(at: 0, effectiveRange: &range!)
//
//                let angle = atan2(label.transform.b, label.transform.a)
//
//                context.translateBy(x: drawPoint.x, y: drawPoint.y)
//                context.rotate(by: angle)
//
//                text.draw(in: outputRect, withAttributes: attributes)
//
//                label.font = originalFont
//            }
//        }
//
//        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return outputImage
//    }
//}
