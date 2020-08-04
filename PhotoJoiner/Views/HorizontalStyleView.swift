//
//  HorizontalStyleView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 03.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

struct HorizontalStyleView: View {
    
    @ObservedObject var viewModel: ImagesViewModel
    
    var body: some View {
        Text("I'm horizontal")
    }
}

struct HorizontalStyleView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalStyleView(viewModel: ImagesViewModel())
    }
}
