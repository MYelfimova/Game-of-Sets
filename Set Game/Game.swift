//
//  Game.swift
//  Set Game
//
//  Created by Maria Yelfimova on 3/2/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import Foundation

class Game{
    
    //here I collect sets
    private(set) var cards: [Card] = []
    
    func checkMatching() {
        let selectedCardsIds = cards.indices.filter({cards[$0].isSelected}).map{cards[$0].identifier}
        print("selected cards: /(selectedCards)")
        let selectedCardsIndices = cards.indices.filter({cards[$0].isSelected})
        let selectedCards = cards.filter({$0.isSelected})
        //If you can sort a group of three cards into "two of ____ and one of ____", then it is not a set.
        if (((selectedCards[0].shape == selectedCards[1].shape) && (selectedCards[0].shape == selectedCards[2].shape) && (selectedCards[1].shape == selectedCards[2].shape))
            ||
            ((selectedCards[0].shape != selectedCards[1].shape) && (selectedCards[0].shape != selectedCards[2].shape) && (selectedCards[1].shape != selectedCards[2].shape))
            ||
            ((selectedCards[0].color == selectedCards[1].color) && (selectedCards[0].color == selectedCards[2].color) && (selectedCards[1].color == selectedCards[2].color))
            ||
            ((selectedCards[0].color != selectedCards[1].color) && (selectedCards[0].color != selectedCards[2].color) && (selectedCards[1].color != selectedCards[2].color))
            ||
            ((selectedCards[0].shade == selectedCards[1].shade) && (selectedCards[0].shade == selectedCards[2].shade) && (selectedCards[1].shade == selectedCards[2].shade))
            ||
            ((selectedCards[0].shade != selectedCards[1].shade) && (selectedCards[0].shade != selectedCards[2].shade) && (selectedCards[1].shade != selectedCards[2].shade)))
            {
                print("cards were matched")
                cards.remove(at: selectedCardsIndices[2])
                cards.remove(at: selectedCardsIndices[1])
                cards.remove(at: selectedCardsIndices[0])
                for i in 0..<36 {
                    cards[i].isVisible = true
                }
        }
    }

    init() {
        for _ in 1..<82 {
            self.cards.append(Card())
        }
    }
    
    
}
