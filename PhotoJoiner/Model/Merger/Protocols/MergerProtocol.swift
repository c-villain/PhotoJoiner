//
//  MergerProtocol.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 05.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

protocol MergerProtocol{
    
    func getMergedSize(images: [PhotoImage], spaceBetweenImages:CGFloat) -> CGSize
    func mergePhotos(images: [PhotoImage], spaceBetweenImages:CGFloat) -> UIImage?
}
