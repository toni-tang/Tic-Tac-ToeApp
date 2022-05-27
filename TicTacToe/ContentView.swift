//
//  ContentView.swift
//  TicTacToe
//
//  Created by Tony Tang on 5/12/22.
//

import SwiftUI

struct ContentView: View {
    
    let columns: [GridItem]  = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())]
    
    @State private var turn: Bool = false
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            BackgroundView()
            GeometryReader { geometry in
                VStack {
                    HStack {
                        TurnBarView(turn: $turn)
                    }
                    LazyVGrid(columns: columns){
                        ForEach(0..<9) { i in
                            ZStack {
                                Circle()
                                    .foregroundColor(.pink)
                                    .opacity(0.8)
                                    .frame(width: geometry.size.width/3 - 15,
                                           height: geometry.size.width/3 - 15)
                                
                                Image(systemName: moves[i]?.indicator ?? "")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                            }
                            .onTapGesture {
                                if isSquareOccupied(in: moves, forIndex: i) { return }
                                moves[i] = Move(player: .human, boardIndex: i)
                                turn.toggle()
                                
                                if checkWinCondition(for: .human, in: moves) {
                                    alertItem = AlertContext.humanWin
                                    return
                                }
                                
                                if checkDrawCondition(in: moves){
                                    alertItem = AlertContext.draw
                                    return
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    let computerPosition = determineComputerMovePosition(in: moves)
                                    moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
                                    turn.toggle()
                                    
                                    if checkWinCondition(for: .computer, in: moves) {
                                        alertItem = AlertContext.computerWin
                                        return
                                    }
                                    
                                    if checkDrawCondition(in: moves){
                                        alertItem = AlertContext.draw
                                        return
                                    }
                                }
                            }
                        }
                    }
                    .disabled(turn)
                    .padding()
                    .alert(item: $alertItem, content: { alertItem in
                        Alert(title: alertItem.title,
                              message: alertItem.message,
                              dismissButton: .default(alertItem.buttonTitle,
                                                      action: resetGame))
                    })
                    
                    
                    Spacer()
                }
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: {$0?.boardIndex == index})
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPositions = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvaliable  = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvaliable { return winPositions.first! }
            }
        }
        
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPositions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvaliable  = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvaliable { return winPositions.first! }
            }
        }
        
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool{
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPositions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) { return true }
        
        return false
    }
    
    func checkDrawCondition(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        turn = false;
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("salmon"), Color("lightPink")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea(.all)
    }
}

struct TurnBarView: View {
    
    @Binding var turn: Bool
    
    var body: some View {
        Text((turn) ? "O's Turn" : "X's Turn")
            .foregroundColor(.white)
            .font(.system(size: 40, weight: .heavy))
            .padding([.bottom, .top], 70)
    }
}

enum Player{
    case human, computer
}

struct Move{
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}
