//
//  ViewController.swift
//  Set Game
//
//  Created by Maria Yelfimova on 3/2/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        
        //print(game.cards)
        //print(game.cards[7].identifier)
    }

    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    // so far only selection and deselection is implemented
    @IBAction func touchCard(_ sender: UIButton) {
        // TODO: with this logic I should implement in choose card logic REMOVING MATCHED cards from the game.card array!
        if let cardNumber = cardButtons.firstIndex(of: sender){
            
            game.cards[cardNumber].isSelected = true
            
            // TODO: game.choose card - is the method were I should implement MATCHING LOGIC
            //game.chooseCard(at: cardNumber)
            
            let selectedCardsIndices = game.cards.indices.filter({game.cards[$0].isSelected})
            if selectedCardsIndices.count <= 3 {
                let button = sender
                button.layer.borderWidth = button.layer.borderWidth == 3.0 ? 0 : 3.0
                button.layer.borderColor = UIColor.gray.cgColor
                button.layer.cornerRadius = button.layer.cornerRadius == 8.0 ? 0 : 8.0
            } else {
                for card in game.cards {
                    card.isSelected = false
                }
                game.cards[cardNumber].isSelected = true
                for index in selectedCardsIndices {
                    let button = cardButtons[index]
                    button.layer.borderWidth = button.layer.borderWidth == 3.0 ? 0 : 3.0
                    button.layer.borderColor = UIColor.gray.cgColor
                    button.layer.cornerRadius = button.layer.cornerRadius == 8.0 ? 0 : 8.0
                }
            }
            
            updateViewFromModel()
        }//isSelected
    }
    
    @IBAction func Deal3MoreCards(_ sender: UIButton) {
    }
    
    @IBAction func NewGameBtn(_ sender: UIButton) {
    }
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    private var game = Game()
    
    
    private func updateViewFromModel(){
        
        let cardsVisible = game.cards.filter({$0.isVisible})
        for index in cardButtons.indices {
            
            let button = cardButtons[index]
            let card = cardsVisible[index]

            let string = card.shape
            let attributes: [NSAttributedString.Key: Any] = [
                .backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                //fileld
                .strokeWidth: -0.1,
                .strokeColor: UIColor.yellow,
                //.foregroundColor: UIColor.red,
                .font: UIFont.boldSystemFont(ofSize: 54)
            ]

            let attributedString = NSAttributedString(string: string, attributes: attributes)
            
            button.setAttributedTitle(attributedString, for: UIControl.State.normal)


        }
        

    }
}
