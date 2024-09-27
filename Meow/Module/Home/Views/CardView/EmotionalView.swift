//
//  EmotionalView.swift
//  Meow
//
//  Created by phrygian on 2024/9/27.
//

import SwiftUI

struct EmotionalView: View {
    let xOffset: CGFloat
    let yOffset: CGFloat
    let dragCurrentState: SwipeAction
    
    var body: some View {
        //MARK: LIKE & NOPE WHEN SWIPING
        HStack() {
            Image("yes")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .opacity(Double(xOffset/40 - 1))
            Spacer()
            Image("nope")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150)
                .opacity(Double(-xOffset/40 - 1))
        }
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
        
        HStack(alignment: .center) {
            Spacer()
            Text("SUPER LIKE")
                .font(.system(size: 25, weight: .medium))
                .foregroundStyle(.blue)
                .padding()
                .background(Color.clear)
                .overlay(
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(.blue, lineWidth: 7)
                )
                .cornerRadius(7)
                .frame(width: 170)
                .rotationEffect(.init(degrees: -10))
                .opacity(dragCurrentState != .superLike ? 0 : abs(Double(yOffset/60)) - 1)
            Spacer()
        }
        .padding(.top, 120)
    }
}

#Preview {
    EmotionalView(xOffset: 110, yOffset: 10, dragCurrentState: .like)
}
