//
//  SearchingView.swift
//  Meow
//
//  Created by phrygian on 2024/9/27.
//

import SwiftUI

struct SearchingView: View {
    @State var animateCircle1 = false
    @State var animateCircle2 = false
    
    var body: some View {
        ZStack {
            Circle().fill(Color.pink.opacity(0.2)).frame(width: 300, height: 300).scaleEffect(animateCircle1 ? 1.2 : 0.1)
                .opacity(animateCircle1 ? 0 : 1)
            Circle().fill(Color.pink.opacity(0.1)).frame(width: 300, height: 300).scaleEffect(animateCircle2 ? 1.2 : 0.1)
                .opacity(animateCircle2 ? 0 : 1)
            Image("tinder-icon")
                .resizable()
                .frame(width: 80, height: 80)
        }
        .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: animateCircle1)
        .animation(.linear(duration: 1.5).repeatForever(autoreverses: false), value: animateCircle2)
        .onAppear(perform: {
            animateCircle1.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                animateCircle2.toggle()
            })
        })
    }
}

#Preview {
    SearchingView()
}
