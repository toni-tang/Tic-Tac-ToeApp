//
//  GameView.swift
//  TicTacToe
//
//  Created by Tony Tang on 5/12/22.
//

import SwiftUI

struct MenuView: View {
    
    var body: some View {
        NavigationView {
            ZStack{
                BackgroundView()
                    .navigationTitle(Text("Menu"))
                    .navigationBarHidden(true)
                VStack(spacing: 30) {
                    Text("Tic-Tac-Toe")
                        .frame(width: 300, height: 100)
                        .foregroundColor(Color("text"))
                        .font(.system(size: 50, weight: .heavy))
                        .padding([.bottom], 40)
                    NavigationLink(destination: GameView(), label: {
                        MenuButtonView(buttonName: "Play")
                    })
                    NavigationLink(destination: CreditView(), label: {
                        MenuButtonView(buttonName: "Credits")
                    })
                }
                .padding([.bottom], 10)
            }
        }
        .accentColor(Color("text"))
    }
}

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            GeometryReader { geometry in
                VStack {
                    Text((viewModel.turn) ? "O's Turn" : "X's Turn")
                        .foregroundColor(Color("text"))
                        .font(.system(size: 40, weight: .heavy))
                        .padding([.bottom, .top], 20)
                    
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

struct CreditView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Text("MIT License \n\nCopyright (c) 2022 Tony \n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: \n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software. \n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.")
                    .foregroundColor(Color("text"))
                    .frame(width: 300, height: 460)
                    .font(.system(size: 12, weight: .heavy))
                Spacer()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView().preferredColorScheme(.light)
        MenuView().preferredColorScheme(.dark)
    }
}
