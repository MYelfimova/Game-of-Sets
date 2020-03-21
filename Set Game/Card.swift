//
//  Card.swift
//  Set Game
//
//  Created by Maria Yelfimova on 3/2/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import Foundation
import UIKit

class Card : CustomStringConvertible {
    
    var description: String {
        return "a \(self.color) \(self.shade) \(self.shape) of number: \(self.number)\n"
    }
    
    var deck = FullDeck()
    
    let identifier: Int
    var isMatched = false
    var isVisible = false
    var isSelected = false
    
    var shape: String
    var color: String
    var shade: String
    var number: String
    
    private static var identifierFactory = 0

// now when I'm gonna be deleting matched in set cards with the identifier == the [n]
    private static func getIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getIdentifier()
        self.isVisible = self.identifier < 25 ? true : false
        let temporaryCard = deck.allCards.remove(at: 0)
        self.shape = temporaryCard["shape"] ?? "?"
        self.color = temporaryCard["color"] ?? "?"
        self.shade = temporaryCard["shade"] ?? "?"
        self.number = temporaryCard["number"] ?? "?"
    }
}


