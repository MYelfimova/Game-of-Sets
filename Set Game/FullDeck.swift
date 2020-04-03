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

    var cards = [Card]()
    
    init() {
        for number in Card.Number.all {
            for shape in Card.Shape.all {
                for shade in Card.Shade.all {
                    for color in Card.Color.all {
                        cards.append(Card (number: number, shape: shape, shade: shade, color: color))
                    }
                }
            }
        }
        self.cards = self.cards.sorted(by: {$0.identifier < $1.identifier})
    }

}
