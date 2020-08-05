//
//  MergerProtocol.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 05.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

protocol ImageMergerProtocol{
    
    func getMergedSize(images: [PhotoImage], spaceBetweenImages:CGFloat) -> CGSize
    func merge(images: [PhotoImage], spaceBetweenImages:CGFloat) -> UIImage?
}
