//
//  HomeNavigationView.swift
//  Meow
//
//  Created by phrygian on 2024/9/27.
//

import SwiftUI

//MARK: TOP NAVIGATION VIEW
struct HomeNavigationView: View {
    var body: some View {
        HStack {
            Image("tinder-icon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
            Text("tinder")
                .font(.system(size: 25, weight: .bold))
                .foregroundColor(.pink)
                .padding(.leading, -7)
            Spacer()
            Button(action: {
                
            }, label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .frame(width: 23, height: 26)
                    .tint(.gray)
                    .padding(.trailing, 10)
            })
            Button(action: {
                
            }, label: {
                Image("boost")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .padding(.trailing, 5)
            })
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
        .frame(height: 36)
    }
}

#Preview {
    HomeNavigationView()
}
