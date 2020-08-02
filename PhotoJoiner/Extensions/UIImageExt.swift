//
//  ImageExt.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 03.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

extension UIImage: Identifiable{
    public var id: String {
        UUID().uuidString
    }
}
