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
    }
    
    var numberOfVisibleCards: Int {
        get {
            return (game.cards.indices.filter({game.cards[$0].isVisible})).count
        }
    }
    
    var add3MoreBtnIsActive: Bool {
        return (numberOfVisibleCards < 22 && game.cards.count != numberOfVisibleCards)
    }

    var score = 0

    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    // so far only selection and deselection is implemented
    @IBAction func touchCard(_ sender: UIButton) {
        print("total number of cards left from the deck: \(game.cards.count)\n")
        // TODO: with this logic I should implement in choose card logic REMOVING MATCHED cards from the game.card array!
        if let cardNumber = cardButtons.firstIndex(of: sender){
            
            if game.cards[cardNumber].isSelected {
                game.cards[cardNumber].isSelected = false
                score -= 1
            } else {
                game.cards[cardNumber].isSelected = true
            }
            //game.cards[cardNumber].isSelected = game.cards[cardNumber].isSelected ? false : true // SELECTION LOGIC
            
            let selectedCardsIndices = game.cards.indices.filter({game.cards[$0].isSelected})
            
            doSelection(indices: selectedCardsIndices) // SELECTION LOGIC
            
            switch selectedCardsIndices.count {
            case 1, 2 :

                print("1 or 2 cards selected")
                print("cards selected indices: \(selectedCardsIndices)")
                print("cards VISIBLE indices:  \(numberOfVisibleCards)\n")

            case 3:
                print("3 cards selected")
                print("cards selected indices before matching func: \(selectedCardsIndices)")
                print("cards VISIBLE indices before matching:  \(game.cards.indices.filter({game.cards[$0].isVisible}))")
                if (game.checkMatching()) {
                    doSelection(indices: [])
                    score += 3
                    print("match was made")
                }
                print("cards selected indices after matching func: \(game.cards.indices.filter({game.cards[$0].isSelected}))")
                print("cards VISIBLE indices after matching:  \(game.cards.indices.filter({game.cards[$0].isVisible}))\n")
                
            case 4:
                print("4 cards selected")
                print("cards selected indices : \(selectedCardsIndices)")
                for index in selectedCardsIndices {
                    game.cards[index].isSelected = false
                }
                game.cards[cardNumber].isSelected = true
                doSelection(indices: [cardNumber])
                score -= 5
                
                print("cards selected indices after deselection: \(game.cards.indices.filter({game.cards[$0].isSelected}))")
                print("cards VISIBLE indices:  \(game.cards.indices.filter({game.cards[$0].isVisible}))\n")
                
            default:
                print("nothing selected so far")
                 print("cards selected indices : \(selectedCardsIndices) + double-check: \(game.cards.indices.filter({game.cards[$0].isSelected}))")
                print("cards VISIBLE indices:  \(game.cards.indices.filter({game.cards[$0].isVisible}))\n")
            }
            
            updateViewFromModel()
        }
    }
    
    @IBOutlet weak var Deal3MoreCardsButton: UIButton!
    
    @IBAction func Deal3MoreCards(_ sender: UIButton) {
        if add3MoreBtnIsActive {
            game.cards[numberOfVisibleCards].isVisible = true
            game.cards[numberOfVisibleCards].isVisible = true
            game.cards[numberOfVisibleCards].isVisible = true
        }
        updateViewFromModel()
    }
    
    @IBAction func NewGameBtn(_ sender: UIButton) {
 
    }
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    private func doSelection(indices: [Int]) {
        for card in cardButtons{
            card.layer.borderWidth = 0
            card.layer.cornerRadius = 0
        }
        for index in indices {
            cardButtons[index].layer.borderWidth = 3.0
            cardButtons[index].layer.borderColor = UIColor.gray.cgColor
            cardButtons[index].layer.cornerRadius = 8.0
        }
    }

    var game = Game()
    
    
    private func updateViewFromModel(){
        
        ScoreLabel.text = String("Score: \(score)")
        
        if add3MoreBtnIsActive{
            Deal3MoreCardsButton.isEnabled = true
            Deal3MoreCardsButton.setTitleColor(UIColor.green, for: UIControl.State.normal)
        } else {
            Deal3MoreCardsButton.isEnabled = false
            Deal3MoreCardsButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        }
        
        let cardsVisible = game.cards.filter({$0.isVisible})
        for index in cardButtons.indices {
            
            if (index) >= numberOfVisibleCards {
                let button = cardButtons[index]
                button.isHidden = true
                button.isEnabled = false
            }
            else {
                // here I show that indices of logic cards and UI card MATCH!
                let button = cardButtons[index]
                let card = cardsVisible[index]
                
                button.isHidden = false
                button.isEnabled = true

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
}

