//
//  UserInfoBottomView.swift
//  Meow
//
//  Created by phrygian on 2024/9/27.
//

import SwiftUI

struct UserInfoBottomView: View {
    let card: CardModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(card.name).font(.largeTitle).fontWeight(.bold)
                    Text("\(card.age)").font(.title)
                }
                Text(card.bio)
            }
        }
        .padding(.bottom, 45)
        .padding([.leading, .trailing], 15)
        .foregroundColor(.white)
    }
}

#Preview {
    UserInfoBottomView(card: CardModel.mockData[0])
        .background(.black)
}
