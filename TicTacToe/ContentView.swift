//
//  ContentView.swift
//  TicTacToe
//
//  Created by Tony Tang on 5/12/22.
//

import SwiftUI

let columns: [GridItem]  = [GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible())]

struct ContentView: View {
    var body: some View {
        ZStack{
            BackgroundView()
            LazyVGrid(columns: columns){
                BoxView()
                BoxView()
                BoxView()
                BoxView()
                BoxView()
                BoxView()
                BoxView()
                BoxView()
                BoxView()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BoxView: View {
    var body: some View {
        Button{
            print(5)
        } label: {
            Text("")
                .frame(width: 100, height: 100)
                .background(.pink)
                .foregroundColor(.white)
                .cornerRadius(50)
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("salmon"), Color("lightPink")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
    }
}
