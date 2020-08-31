//
//  MultipleImagePickerSheet.swift
//  MultipleImagePicker
//
//  Created by ibrahimyilmaz on 26.05.2020.
//  Copyright © 2020 ibrahimyilmaz. All rights reserved.
//

import SwiftUI
import Photos
import Combine

struct MultipleImagePickerSheet: View {
    @Binding var pickerShowed: Bool
    
    @State var doneAction: ([String]) -> ()
    
    @State var selectedIds = [String]()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                MultipleImagePicker()
                    .onPreferenceChange(AssetImageSelectablePreferenceKey.self) { imageIds in
                        self.selectedIds = imageIds ?? []
 
                }
            }
            
            .navigationBarTitle("Photos", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.pickerShowed.toggle()
                    }, label: {
                        Text("Close")
                    }),
                trailing:
                    Button(action: {
                        self.pickerShowed.toggle()
                        self.doneAction(self.selectedIds)
                    }, label: {
                        Text("Add (\(selectedIds.count))").bold()
                    }).disabled(selectedIds.count == 0)
            )
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}
