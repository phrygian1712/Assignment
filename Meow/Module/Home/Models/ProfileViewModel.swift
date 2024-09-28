//
//  ProfileViewModel.swift
//  Meow
//
//  Created by phrygian on 2024/9/25.
//

import Foundation

enum HomeViewState {
    case fetching
    case reloadData
    case none
}

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var state: HomeViewState = .none {
        didSet {
//            print("State change: \(state)")
        }
    }
    @Published var cards = [CardModel]()
    @Published var dragCurrentState: SwipeAction = .none
    
    private let service: CardService
    
    init(service: CardService) {
        self.service = service
        Task { await fetchData() }
    }
    
    #warning("need to limit the number of cards view to improve perfomance, implement later...")
    func fetchData() async {
        print("fetch data...")
        state = .reloadData
        do {
            self.cards = try await service.fetchCardModels()
            state = .none
        } catch {
            state = .none
            print("DEBUG: failed with error: \(error)")
        }
    }
    
    func removeCard(_ card: CardModel) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }
        cards.remove(at: index)
    }
    
}
