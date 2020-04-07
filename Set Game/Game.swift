//
//  Game.swift
//  Set Game
//
//  Created by Maria Yelfimova on 3/2/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import Foundation

class Game{
    
    private(set) var cards: [Card] = []
    
    func checkMatching() -> Bool {

        let selectedCardsIndices = cards.indices.filter({cards[$0].isSelected})
        let selectedCards = cards.filter({$0.isSelected})
        
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
            ((selectedCards[0].shade != selectedCards[1].shade) && (selectedCards[0].shade != selectedCards[2].shade) && (selectedCards[1].shade != selectedCards[2].shade))
            ||
            ((selectedCards[0].number == selectedCards[1].number) && (selectedCards[0].number == selectedCards[2].number) && (selectedCards[1].number == selectedCards[2].number))
            ||
            ((selectedCards[0].number != selectedCards[1].number) && (selectedCards[0].number != selectedCards[2].number) && (selectedCards[1].number != selectedCards[2].number)))
            {
                for index in selectedCardsIndices {
                    cards[index].isMatched = true
                }
                // Here I add logic whether a matching set should replace cards, or append them at the end
                if ((cards.indices.filter({cards[$0].isVisible})).count < 13)
                    && (cards.count != (cards.indices.filter({cards[$0].isVisible})).count){
                    cards.swapAt(selectedCardsIndices[2], cards.count-1)
                    cards.swapAt(selectedCardsIndices[1], cards.count-2)
                    cards.swapAt(selectedCardsIndices[0], cards.count-3)
                    cards.remove(at: cards.count-1)
                    cards.remove(at: cards.count-1)
                    cards.remove(at: cards.count-1)
                    
                    for index in selectedCardsIndices {
                        cards[index].isSelected = false
                        cards[index].isVisible = true
                    }
                } else {
                    cards.remove(at: selectedCardsIndices[2])
                    cards.remove(at: selectedCardsIndices[1])
                    cards.remove(at: selectedCardsIndices[0])
                }
                return true;
        }
        return false;
    }

    init() {
        self.cards = FullDeck().cards
    }
    
    
}
