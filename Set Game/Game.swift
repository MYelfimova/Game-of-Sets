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
    

    init() {
        for _ in 1..<82 {
            self.cards.append(Card())
        }
    }
    
    
}
