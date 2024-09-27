//
//  ImageScrollingView.swift
//  Meow
//
//  Created by phrygian on 2024/9/25.
//

import SwiftUI

struct ImageScrollingOverlay: View {
    @Binding var currentImageIndex: Int
    @Binding var isFlip: Bool
    let imageCount: Int
    
    var body: some View {
        HStack {
            Rectangle()
                .onTapGesture { updateImageIndex(increment: false) }
            Rectangle()
                .onTapGesture { updateImageIndex(increment: true) }
        }
        .foregroundColor(.white.opacity(0.01))
    }
}

private extension ImageScrollingOverlay {
    func updateImageIndex(increment: Bool) {
        if imageCount <= 1 { return }
        if increment {
            guard currentImageIndex < imageCount - 1 else {
                withAnimation {
                    isFlip = true
                } completion: {
                    isFlip = false
                }
                return
            }
            currentImageIndex += 1
        } else {
            guard currentImageIndex > 0 else {
                withAnimation {
                    isFlip = true
                } completion: {
                    isFlip = false
                }
                return
            }
            currentImageIndex -= 1
        }
    }
}

