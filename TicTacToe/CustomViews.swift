//
//  CustomViews.swift
//  TicTacToe
//
//  Created by Tony Tang on 6/1/22.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("salmon"), Color("lightPink")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
    }
}

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.pink)
            .opacity(0.8)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}

struct playerIndicatorView: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}

struct MenuButtonView: View {
    
    var buttonName: String
    
    var body: some View {
        ZStack {
            Text("")
                .frame(width: 200, height: 100)
                .background(.pink)
                .cornerRadius(100)
                .opacity(0.8)
            Text(buttonName)
                .frame(width: 200, height: 100)
                .foregroundColor(.white)
                .font(.system(size: 25, weight: .heavy))
        }
    }
}

