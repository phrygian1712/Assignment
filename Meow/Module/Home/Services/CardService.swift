//
//  CardService.swift
//  Meow
//
//  Created by phrygian on 2024/9/25.
//

import Foundation

struct CardService {
    
    func fetchCardModels() async throws -> [CardModel] {
        try? await Task.sleep(nanoseconds: 6_000_000_000) // 6 seconds delay
        return CardModel.mockData
    }
    
}
