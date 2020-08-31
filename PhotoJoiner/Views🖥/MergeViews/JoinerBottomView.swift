//
//  JoinerBottomView.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 10.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

struct JoinerBottomView: View {
    
    @ObservedObject var viewModel: ImagesViewModel
    
    private let shuffleTappedCallback: (Bool) -> ()
    private let savingTappedCallback: () -> ()
    
    public init(viewModel: ImagesViewModel,
                 shuffleTapped: @escaping (Bool) -> (),
                 savingTapped: @escaping () -> () ){
        self.viewModel = viewModel
        self.shuffleTappedCallback = shuffleTapped
        self.savingTappedCallback = savingTapped
    }
    
    func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
    }
    
    var body: some View {
        HStack{
                        
            Button(action: {
                withAnimation{
                    DispatchQueue.main.async {
                        self.shuffleTappedCallback(false)
                        self.viewModel.shuffle()
                        self.shuffleTappedCallback(true)
                    }
                }
            }) {
                HStack(spacing: 6){
                    Text("Shuffle")
                    Image("Shuffle")
                        .renderingMode(.template)
                        .foregroundColor(.white)
                }.foregroundColor(.white)
                .padding()
            }
            .background(Color("Color"))
            .cornerRadius(8)
            
            Spacer()
            Button(action: {
                self.viewModel.saveMergedImage()
                savingTappedCallback()
            }) {
                HStack(spacing: 6){
                    Text("Join photos")
                    Image("arrow").renderingMode(.original)
                }.foregroundColor(.white)
                .padding()
            }
            .background(Color("Color"))
            .cornerRadius(8)
            
        }
    }
}

struct JoinerBottomView_Previews: PreviewProvider {
    @Binding var showingTopPopup: Bool
    static var previews: some View {
        let merger = Merger()
        let saver = Saver()
        JoinerBottomView(viewModel: ImagesViewModel(merger: merger,
                                                    saver: saver), shuffleTapped: {_ in }, savingTapped: {})
        
    }
}
