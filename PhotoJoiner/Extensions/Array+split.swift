//
//  Array+split.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 06.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import Foundation

extension Array {
    func split(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
