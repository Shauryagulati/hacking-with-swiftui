//
//  ContentView.swift
//  Drawing
//
//  Created by Shaurya Gulati on 19/07/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: 400, y: 100))
            path.addLine(to: CGPoint(x: 100, y: 400))
            path.addLine(to: CGPoint(x: 400, y: 400))
            path.addLine(to: CGPoint(x: 400, y: 100))
        }
        .stroke(Color.black, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
