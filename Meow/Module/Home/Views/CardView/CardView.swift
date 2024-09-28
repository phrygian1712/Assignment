//
//  ProfileView.swift
//  Meow
//
//  Created by phrygian on 2024/9/25.
//

import Foundation
import SwiftUI
enum SwipeAction {
    case like
    case nope
    case superLike
    case none
}

struct CardView: View {
    var card: CardModel
    @ObservedObject var viewModel: ProfileViewModel
    
    /// ProfileView x position
    @State private var xOffset: CGFloat  = 0.0
    /// ProfileView y position
    @State private var yOffset: CGFloat  = 0.0
    /// ProfileView rotation angle
    @State private var degree: Double    = 0.0
    @State private var currentImageIndex = 0
    /// When click on the last or first image, little flip effect
    @State private var isFlip = false
    @State var isTopItem: Bool
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            //MARK: for background layer
            ZStack { Color.clear }
            .background(Color(hex: "d5ddf3"))
            .cornerRadius(15)
            .padding([.leading, .trailing], 10)
            .opacity(isTopItem ? 1 - abs(Double(yOffset/2)) : 0)
            .animation(.easeInOut(duration: 0.5), value: isTopItem)
            
            //MARK: CARD IMAGE AND IDICATOR
            ZStack(alignment: .top) {
                if card.images.count == 0 {
                    Image("defaultImg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else {
                    GeometryReader { geo in
                        Image(card.images[currentImageIndex])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .overlay {
                                ImageScrollingOverlay(currentImageIndex: $currentImageIndex, isFlip: $isFlip, imageCount: card.images.count)
                            }
                            .frame(width: geo.size.width ,height: geo.size.height)
                    }
                    ImageIndicatorView(currentImageIndex: currentImageIndex, imageCount: card.images.count)
                }
            }
            .cornerRadius(10)
            .padding(.bottom, 17)
            
            UserInfoBottomView(card: card)
            
            EmotionalView(xOffset: xOffset, yOffset: yOffset, dragCurrentState: viewModel.dragCurrentState)
            
        }
        .cornerRadius(8)
        .offset(x: xOffset, y: yOffset)
        .rotationEffect(.init(degrees: degree))
        .rotation3DEffect(
            .degrees(isFlip ? currentImageIndex == 0 ? -2 : 2 : 0), axis: (x: 0, y: 1, z: 0)
        )
        .animation(.easeInOut(duration: 0.1), value: isFlip)
        .scaleEffect(isTopItem ? 1 : 0.93)
        .animation(.easeInOut(duration: 0.5), value: isTopItem)
        .gesture(
            DragGesture()
                .onChanged(onDragChanged)
                .onEnded(onDragEnded)
        )
        .disabled(viewModel.state == .fetching)
        .onReceive(NotificationCenter.default.publisher(for: .swipeRightNoti)) { notification in
            handleSwipeNotification(notification: notification, swipe: .like)
        }
        .onReceive(NotificationCenter.default.publisher(for: .swipeLeftNoti)) { notification in
            handleSwipeNotification(notification: notification, swipe: .nope)
        }
        .onReceive(NotificationCenter.default.publisher(for: .swipeUpNoti)) { notification in
            handleSwipeNotification(notification: notification, swipe: .superLike)
        }
        .onReceive(NotificationCenter.default.publisher(for: .finishSelection)) { notification in
            if let userInfo = notification.userInfo,
               let cardId = userInfo["cardId"] as? String,
               card.id == cardId {
                isTopItem = true
            }
        }
    }
    
    private func handleSwipeNotification(notification: Notification,
                                         swipe: SwipeAction) {
        if let userInfo = notification.userInfo,
           let cardId = userInfo["cardId"] as? String,
           card.id == cardId {
            swipeAction(swipe: swipe)
        }
    }
}

//MARK: DRAG HANDLER
private extension CardView {
    
    private func onDragEnded(_ value: _ChangedGesture<DragGesture>.Value) {
        withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 140, damping: 8, initialVelocity: 1)) {
            if viewModel.state == .fetching { return }
            
            let height = value.translation.height
            
            switch value.translation.width {
            case 0...100, (-100)...(-1):
                xOffset = 0; degree = 0;
                if value.translation.height < -120 {
                    finishSelection()
                    yOffset = 1000 * height/120
                } else {
                    yOffset = 0
                }
            case let x where x > 100 || x < -100:
                finishSelection()
                xOffset = 500 * x/100; degree = 12 * x/100
            default:
                xOffset = 0; yOffset = 0;
            }
            viewModel.dragCurrentState = .none
        } completion: {
            if abs(value.translation.width) > 100 ||
                (value.translation.height < -120 && abs(value.translation.width) < 100) {
                viewModel.removeCard(card)
                viewModel.state = viewModel.cards.count == 0 ? .reloadData : .none
            }
        }
    }
    
    private func onDragChanged(_ value: _ChangedGesture<DragGesture>.Value) {
        if viewModel.state == .fetching { return }
        
        withAnimation {
            xOffset = value.translation.width
            yOffset = value.translation.height
            let width = value.translation.width
            
            if abs(value.translation.width) > 25 {
                degree = 6 * (width > 0 ? 1 : -1)
                viewModel.dragCurrentState = width > 0 ? .like : .nope
            } else if value.translation.height < -60 && abs(value.translation.width) < 25 {
                degree = 0.5 * (width > 0 ? 1 : -1)
                viewModel.dragCurrentState = .superLike
            } else {
                degree = 0.2 * (width > 0 ? 1 : -1)
                viewModel.dragCurrentState = .none
            }
        }
    }
    
    private func finishSelection() {
        var userInfo: [String: Any] = [:]
        if viewModel.cards.count > 1 {
            viewModel.state = .fetching
            userInfo = ["cardId": viewModel.cards[viewModel.cards.count - 2].id]
            NotificationCenter.default.post(name: .finishSelection, object: nil, userInfo: userInfo)
        }
    }
    
    private func swipeAction(swipe: SwipeAction) {
        withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 80, damping: 8, initialVelocity: 1)) {
            if swipe == .none || viewModel.cards.isEmpty { return }
            if swipe == .superLike {
                yOffset = -1000
                degree = 2
            } else {
                xOffset = swipe == .like ? 500 : -500
                degree = swipe == .like ? 12 : -12
            }
            finishSelection()
        } completion: {
            viewModel.removeCard(card)
            let userInfo: [String: Any] = ["cardId": viewModel.cards.last?.id ?? ""]
            NotificationCenter.default.post(name: .finishSelection, object: nil, userInfo: userInfo)
            viewModel.state = viewModel.cards.count == 0 ? .reloadData : .none
        }
    }
}

#Preview {
    CardView(card: CardModel.mockData[0],
                viewModel: ProfileViewModel(service: CardService()), isTopItem: true)
}

