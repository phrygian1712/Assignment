//
//  Card.swift
//  Meow
//
//  Created by phrygian on 2024/9/25.
//

import Foundation

struct CardModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let name: String
    let images: [String]
    let age: Int
    let bio: String
    
    static var mockData: [CardModel] {
        [
            CardModel(name:
                        "Nicorobin",
                      images: ["p1", "p7", "p0"],
                      age: 28,
                      bio: "New here! 🍷"),
            CardModel(name:
                        "Nami",
                      images: ["p7", "p2", "p4"],
                      age: 26,
                      bio: "hi, let's be friends 🍷"),
            CardModel(name: "Tilly",
                      images: ["p4", "p7", "p1"],
                      age: 21,
                      bio: "Follow me on IG"),
            CardModel(name: "Betty",
                      images: ["p3", "p4", "p0", "p2", "p7"],
                      age: 23,
                      bio: "Like exercising, going out, pub, working 🍻"),
            CardModel(name: "Tatiana",
                      images: ["p0", "p2"],
                      age: 21,
                      bio: "Insta - roooox 💋"),
        ]
    }
    
}
