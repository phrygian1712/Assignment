//
//  ImageIndicatorView.swift
//  Meow
//
//  Created by phrygian on 2024/9/25.
//

import SwiftUI

struct ImageIndicatorView: View {
    let currentImageIndex: Int
    let imageCount: Int
    
    var body: some View {
        HStack {
            if imageCount > 1 {
                ForEach(0..<imageCount, id: \.self) { index in
                    Capsule()
                        .foregroundColor(currentImageIndex == index ? .white : .black.opacity(0.6))
                        .frame(width: indicatorWidth, height: 2.5)
                        .padding(.top, 8)
                }
            }
        }
    }
}

private extension ImageIndicatorView {
    var indicatorWidth: CGFloat {
        return (UIScreen.main.bounds.width - 16) / CGFloat(imageCount) - 10
    }
}

#Preview {
    ImageIndicatorView(currentImageIndex: 1, imageCount: 3)
}

