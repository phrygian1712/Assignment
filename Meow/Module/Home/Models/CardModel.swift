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
            CardModel(name: "Penny", images:
                        ["p5", "p0"],
                      age: 24,
                      bio: "J'aime la vie et le vin J'aime la vie et le vin J'aime la vie et le vin J'aime la vie et le vin 🍷"),
            CardModel(name:
                        "Abigail",
                      images: ["p2", "p3", "p4"],
                      age: 26,
                      bio: "hi, let's be friends"),
            CardModel(name: "Zoé",
                      images: ["p3", "p5", "p3", "p2"],
                      age: 20, bio: "Law grad"),
            CardModel(name: "Tilly",
                      images: ["p4", "p1"],
                      age: 21,
                      bio: "Follow me on IG"),
            CardModel(name: "Betty",
                      images: ["p1", "p5", "p4", "p0", "p2"],
                      age: 23,
                      bio: "Like exercising, going out, pub, working 🍻"),
            CardModel(name: "Tatiana",
                      images: ["p0", "p3", "p2"],
                      age: 21,
                      bio: "Insta - roooox 💋"),
        ]
    }
    
}
