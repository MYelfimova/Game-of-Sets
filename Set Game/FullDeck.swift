//
//  File.swift
//  Set Game
//
//  Created by Maria Yelfimova on 3/7/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import Foundation
import UIKit

class FullDeck {
    
    static var shape = ["▲","●","■"]
    static var color = ["red", "yellow", "green"]
    static var shade = ["striped", "filled", "outline"]
    static var number = ["1", "2", "3"]
    

    var allCards: [Dictionary<String, String>] = []
    
    
    init() {
        for i in FullDeck.shape {
            for j in FullDeck.color {
                for k in FullDeck.shade {
                    for h in FullDeck.number {
                        self.allCards.append(["shape": i, "color": j, "shade": k, "number": h])
                    }
                }
            }
        }
        self.allCards.shuffle()
    }
}
