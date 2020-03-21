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
    
    func checkMatching() -> Bool {
        //let selectedCardsIds = cards.indices.filter({cards[$0].isSelected}).map{cards[$0].identifier}
        //print("selected cards: \(selectedCardsIds)")
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
            ((selectedCards[0].shade != selectedCards[1].shade) && (selectedCards[0].shade != selectedCards[2].shade) && (selectedCards[1].shade != selectedCards[2].shade)))
            {
                //print("cards were matched")
                for index in selectedCardsIndices {
                    cards[index].isMatched = true
                }
                
//                let cardsVisibleIndices = cards.indices.filter({cards[$0].isVisible})
//                if cardsVisibleIndices.count <= 12 {
                    cards.swapAt(selectedCardsIndices[2], cards.count-1)
                    cards.swapAt(selectedCardsIndices[1], cards.count-2)
                    cards.swapAt(selectedCardsIndices[0], cards.count-3)
                    cards.remove(at: cards.count-1)
                    cards.remove(at: cards.count-1)
                    cards.remove(at: cards.count-1)
                    
//                } else {
//                        cards.remove(at: selectedCardsIndices[2])
//                        cards.remove(at: selectedCardsIndices[1])
//                        cards.remove(at: selectedCardsIndices[0])
//                }
                
                return true;
        }
        return false;
    }

    init() {
        for _ in 0..<81 {
            self.cards.append(Card())
        }
        //self.cards.sorted(by: { $0.isVisible > $1.isVisible })
    }
    
    
}
