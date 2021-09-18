//
//  ContentView.swift
//  Animations
//
//  Created by Shaurya Gulati on 11/06/21.
//

import SwiftUI

struct ContentView: View {
    let letters =  Array("Hello World")
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.yellow : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }
        }
        .gesture(
            DragGesture()
                .onChanged { self.dragAmount = $0.translation }
                .onEnded { _ in
                    self.dragAmount = .zero
                    self.enabled.toggle()
                }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//import SwiftUI
//
//struct ContentView: View {
//
//    @State private var isShowingRed = false
//
//    var body: some View {
//        Button("Tap Me"){
//            withAnimation() {
//                self.isShowingRed.toggle()
//            }
//        }
//
//        if isShowingRed == true {
//            Rectangle()
//                .fill(Color.yellow)
//                .frame(width:200, height:200)
//                .transition(.scale)
////                .transition(.asymmetric(insertion: .scale, removal: .opacity))
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
