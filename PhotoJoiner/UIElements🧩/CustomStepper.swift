//
//  CustomStepper.swift
//  PhotoJoiner
//
//  Created by Alexander Kraev on 24.08.2020.
//  Copyright © 2020 Alexander Kraev. All rights reserved.
//

import SwiftUI

struct CustomStepper : View {
    @Binding private var value: Double
    var step = 1.0
    private let editingChangedCallback: (Bool) -> ()
    
    public init(value: Binding<Double>,
                step: Int = 1,
         onEditingChanged: @escaping (Bool) -> () = { _ in }) {
        self._value = value
        self.editingChangedCallback = onEditingChanged
        self.step = Double(step)
        
    }
    
    var body: some View {
            HStack {
                Text("\(Int(value))")
                    .foregroundColor(Color("Color")).font(.title).padding()

                Button(action: {
                    if self.value > 1 {
                        self.value -= self.step
//                        self.feedback()
                        DispatchQueue.main.async {
                            editingChangedCallback(true)
                        }
                        
                    }
                }, label: {
                    Image(systemName: "minus.square")
                        .foregroundColor(Color("Color"))
                        .font(.system(size: 50.0))
                }).padding()

                
                Button(action: {
                    //if self.value < 2 {
                        self.value += self.step
//                        self.feedback()
                    DispatchQueue.main.async {
                    editingChangedCallback(true)
                    }
                    //}
                }, label: {
                    Image(systemName: "plus.square")
                        .foregroundColor(Color("Color"))
                        .font(.system(size: 50.0))
                }).padding()
        }
    }

    func feedback() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

//struct CustomStepper_Previews: PreviewProvider {
//    @State(initialValue: 1.0) var myvalue: Double
//    static var previews: some View {
//        CustomStepper(value: .constant(1.0))
//    }
//}
