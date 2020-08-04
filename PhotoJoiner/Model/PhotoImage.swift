//
//  PhotoImage.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 03.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

public struct PhotoImage : Identifiable {
    public var id = UUID()
    public var image : UIImage
    public var offset : CGFloat
}
