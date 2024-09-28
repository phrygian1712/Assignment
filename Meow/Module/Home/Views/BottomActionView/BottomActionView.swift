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
    let countCards: Int
    let state: HomeViewState
    
    var body: some View {
        HStack(spacing: 0) {
            ButtonActionView(iconName: "refresh",
                             size: CGSize(width: 60, height: 60),
                             type: .none,
                             dragCurrentAction: dragCurrentAction) {
            }
            
            let heighDismiss:CGFloat = dragCurrentAction == .nope ? 90 : 80
            ButtonActionView(iconName: "dismiss",
                             size: CGSize(width: heighDismiss, height: heighDismiss),
                             type: .nope,
                             dragCurrentAction: dragCurrentAction) {
                sendAction(swipeAction: .nope)
            }
            
            let heighSpLike:CGFloat = dragCurrentAction == .superLike ? 90 : 60
            ButtonActionView(iconName: "super_like",
                             size: CGSize(width: heighSpLike, height: heighSpLike),
                             type: .superLike,
                             dragCurrentAction: dragCurrentAction) {
                sendAction(swipeAction: .superLike)
            }
            
            let heighLike:CGFloat = dragCurrentAction == .like ? 90 : 80
            ButtonActionView(iconName: "like",
                             size: CGSize(width: heighLike, height: heighLike),
                             type: .like,
                             dragCurrentAction: dragCurrentAction) {
                sendAction(swipeAction: .like)
            }
            
            ButtonActionView(iconName: "boost",
                             size: CGSize(width: 60, height: 60),
                             type: .none,
                             dragCurrentAction: dragCurrentAction) { }
        }
        .disabled(state == .reloadData)
        .opacity(state == .reloadData ? 0.4 : 1)
        .animation(.easeOut(duration: 0.5), value: state)
    }
    
    @MainActor private func sendAction(swipeAction: SwipeAction) {
        if state == .fetching || countCards == 0 { return }
        let userInfo: [String: Any] = ["cardId": currentCardId]
        NotificationCenter.default.post(name: swipeAction == .like ? .swipeRightNoti : swipeAction == .nope ? .swipeLeftNoti : .swipeUpNoti, object: nil, userInfo: userInfo)
    }
}

struct ButtonActionView: View {
    let iconName: String
    let size: CGSize
    let type: SwipeAction
    let dragCurrentAction: SwipeAction
    let action: () -> Void
    @State private var isButtonDisabled = false
    
    var body: some View {
        Button(action: {
            performAction()
        }, label: {
            if dragCurrentAction == .none || type == dragCurrentAction {
                Image(iconName)
                    .resizable()
            }
        })
        .frame(width: size.width, height: size.height)
    }
    
    private func performAction() {
        if isButtonDisabled { return }
        isButtonDisabled = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            isButtonDisabled = false
            action()
        }
    }
}

#Preview {
    BottomActionView(dragCurrentAction: .none, currentCardId: "", countCards: 1, state: .fetching)
}
