//
//  PhotoJoinerTests.swift
//  PhotoJoinerTests
//
//  Created by Alexander Kraev on 31.07.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import XCTest
@testable import PhotoJoiner

class PhotoJoinerTests: XCTestCase {

    func testSplitter() throws{
        //Given
        let array = [3,7,9,19,20,11,7,9,16]
        
        //When
        let splitedArray = array.split(into: 2)
        
        //Then
        XCTAssertEqual(splitedArray, [[3,7], [9,19], [20,11], [7,9], [16]])
    }

}
