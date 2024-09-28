//
//  ContentView.swift
//  Meow
//
//  Created by phrygian on 2024/9/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = ProfileViewModel(service: CardService())
    
    var body: some View {
        VStack() {
            //navigation
            HomeNavigationView()
            
            //card
            ZStack(alignment: .bottom) {
                CardStackView(viewModel: viewModel)
                    .padding(.bottom, 45)
                BottomActionView(dragCurrentAction: viewModel.dragCurrentState, currentCardId: viewModel.cards.last?.id ?? "", countCards: viewModel.cards.count, state: viewModel.state)
                    .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    HomeView()
}

//MARK: CARD STACK VIEW
struct CardStackView: View {
    @ObservedObject var viewModel: ProfileViewModel
    
    var body: some View {
        ZStack {
            if viewModel.cards.count == 0 {
                ZStack {
                    Color.clear
                    SearchingView()
                }
            } else {
                ForEach(viewModel.cards) { item in
                    CardView(card: item, viewModel: viewModel, isTopItem: item.id == viewModel.cards.last?.id ?? "")
                }
            }
        }
        .onChange(of: viewModel.cards) { oldValue, newValue in
            if newValue.isEmpty {
                Task { await viewModel.fetchData() }
            }
        }
    }
}



