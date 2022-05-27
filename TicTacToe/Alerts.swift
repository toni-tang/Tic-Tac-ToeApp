//
//  Alerts.swift
//  TicTacToe
//
//  Created by Tony Tang on 5/19/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
    
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Win"),
                                    message: Text(""),
                                    buttonTitle: Text("Play Again"))
    
    static let computerWin = AlertItem(title: Text("You Lost"),
                                       message: Text(""),
                                       buttonTitle: Text("Play Again"))
    
    static let draw = AlertItem(title: Text("Draw"),
                                message: Text(""),
                                buttonTitle: Text("Play Again"))
}
