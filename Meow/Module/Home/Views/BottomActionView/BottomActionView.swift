//
//  BottomActionView.swift
//  Meow
//
//  Created by phrygian on 2024/9/27.
//

import SwiftUI

//MARK: BOTTOM ACTION VIEW
struct BottomActionView: View {
    let dragCurrentAction: SwipeAction
    let currentCardId: String
    var viewModel: ProfileViewModel
    
    var body: some View {
        HStack(spacing: 0) {
            ButtonActionView(iconName: "refresh",
                             size: CGSize(width: 60, height: 60),
                             type: .none,
                             dragCurrentAction: dragCurrentAction,
                             state: viewModel.state) {
            }
            
            let heighDismiss:CGFloat = dragCurrentAction == .nope ? 90 : 80
            ButtonActionView(iconName: "dismiss",
                             size: CGSize(width: heighDismiss, height: heighDismiss),
                             type: .nope,
                             dragCurrentAction: dragCurrentAction,
                             state: viewModel.state) {
                sendAction(swipeAction: .nope)
            }
            
            let heighSpLike:CGFloat = dragCurrentAction == .superLike ? 90 : 60
            ButtonActionView(iconName: "super_like",
                             size: CGSize(width: heighSpLike, height: heighSpLike),
                             type: .superLike,
                             dragCurrentAction: dragCurrentAction,
                             state: viewModel.state) {
                sendAction(swipeAction: .superLike)
            }
            
            let heighLike:CGFloat = dragCurrentAction == .like ? 90 : 80
            ButtonActionView(iconName: "like",
                             size: CGSize(width: heighLike, height: heighLike),
                             type: .like,
                             dragCurrentAction: dragCurrentAction,
                             state: viewModel.state) {
                sendAction(swipeAction: .like)
            }
            
            ButtonActionView(iconName: "boost",
                             size: CGSize(width: 60, height: 60),
                             type: .none,
                             dragCurrentAction: dragCurrentAction,
                             state: viewModel.state) { }
        }
    }
    
    @MainActor private func sendAction(swipeAction: SwipeAction) {
        if viewModel.state == .fetching || viewModel.cards.isEmpty { return }
        viewModel.state = .fetching
        let userInfo: [String: Any] = ["cardId": currentCardId]
        NotificationCenter.default.post(name: swipeAction == .like ? .swipeRightNoti : swipeAction == .nope ? .swipeLeftNoti : .swipeUpNoti, object: nil, userInfo: userInfo)
    }
}

struct ButtonActionView: View {
    let iconName: String
    let size: CGSize
    let type: SwipeAction
    let dragCurrentAction: SwipeAction
    let state: HomeViewState
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            if dragCurrentAction == .none || type == dragCurrentAction {
                Image(iconName)
                    .resizable()
            }
        })
        .frame(width: size.width, height: size.height)
    }
}

#Preview {
    BottomActionView(dragCurrentAction: .none, currentCardId: "", viewModel: ProfileViewModel(service: CardService()))
}
