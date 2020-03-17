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
            
            game.cards[cardNumber].isSelected = game.cards[cardNumber].isSelected ? false : true
            
            // TODO: game.choose card - is the method were I should implement MATCHING LOGIC
            //game.chooseCard(at: cardNumber)
            
            let selectedCardsIndices = game.cards.indices.filter({game.cards[$0].isSelected})
            if selectedCardsIndices.count <= 3 {
                doSelection(button: sender)
            } else {
                for card in game.cards {
                    card.isSelected = false
                }
                game.cards[cardNumber].isSelected = true
                for index in selectedCardsIndices {
                    doSelection(button: cardButtons[index])
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
    
    private func doSelection(button: UIButton) {
        button.layer.borderWidth = button.layer.borderWidth == 3.0 ? 0 : 3.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = button.layer.cornerRadius == 8.0 ? 0 : 8.0
    }
    
    private var game = Game()
    
    
    private func updateViewFromModel(){
        
        let cardsVisible = game.cards.filter({$0.isVisible})
        for index in cardButtons.indices {
            
            // here I show that indices of logic cards and UI card MATCH!
            let button = cardButtons[index]
            let card = cardsVisible[index]

            let shape = card.shape
            
            let color: UIColor
            switch card.color {
                case "red": color = UIColor.red
                case "yellow": color = UIColor.yellow
                case "green": color = UIColor.green
            default: color = UIColor.gray
            }
            
            var attributes: [NSMutableAttributedString.Key: Any]
            switch card.shade {
            case "striped":
                attributes = [.backgroundColor: #colorLiteral(red: 0.9309860233, green: 0.9309860233, blue: 0.9309860233, alpha: 1),
                    .strokeColor: color,
                    .strokeWidth: -0.4,
                    .foregroundColor: color.withAlphaComponent(0.5),
                    .font: UIFont.boldSystemFont(ofSize: 54)
                ]
            case "filled":
                attributes = [.backgroundColor: #colorLiteral(red: 0.9309860233, green: 0.9309860233, blue: 0.9309860233, alpha: 1),
                    //.strokeColor: UIColor.white,
                    .foregroundColor: color,
                    .font: UIFont.boldSystemFont(ofSize: 54)
                ]
            case "outline":
                attributes = [.backgroundColor: #colorLiteral(red: 0.9309860233, green: 0.9309860233, blue: 0.9309860233, alpha: 1),
                    .strokeColor: color,
                    .strokeWidth: 4,
                    .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                    .font: UIFont.boldSystemFont(ofSize: 54)
                ]
            default: attributes = [.backgroundColor: #colorLiteral(red: 0.9309860233, green: 0.9309860233, blue: 0.9309860233, alpha: 1)]
            }
            

            let attributedString = NSAttributedString(string: shape, attributes: attributes)
            
            button.setAttributedTitle(attributedString, for: UIControl.State.normal)


        }
        

    }
}
