//
//  Model.swift
//  TicTacToe
//
//  Created by Tony Tang on 6/1/22.
//

import SwiftUI

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
