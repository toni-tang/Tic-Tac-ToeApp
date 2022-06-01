//
//  GameView.swift
//  TicTacToe
//
//  Created by Tony Tang on 5/12/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            GeometryReader { geometry in
                VStack {
                    HStack {
                        Text((viewModel.turn) ? "O's Turn" : "X's Turn")
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .heavy))
                            .padding([.bottom, .top], 70)
                    }
                    LazyVGrid(columns: viewModel.columns){
                        ForEach(0..<9) { i in
                            ZStack {
                                GameSquareView(proxy: geometry)
                                playerIndicatorView(systemImageName: viewModel.moves[i]?.indicator ?? "")
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(for: i)
                            }
                        }
                    }
                    .disabled(viewModel.turn)
                    .padding()
                    .alert(item: $viewModel.alertItem, content: { alertItem in
                        Alert(title: alertItem.title,
                              message: alertItem.message,
                              dismissButton: .default(alertItem.buttonTitle, action: viewModel.resetGame))
                    })
                    
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
