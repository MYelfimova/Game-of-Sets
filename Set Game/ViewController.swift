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
    }
    var numberOfVisibleCards: Int {
        get {
            //return deck.grid.cellCount
            return (deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isVisible})).count
        }
    }

    var add3MoreBtnIsActive: Bool {
        return (numberOfVisibleCards < 30 && deckOfCards.game.cards.count != numberOfVisibleCards)
    }
        
    var selectedCardsNumber: Int {
        get {
            return (deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isSelected})).count
        }
    }
    
    var lastSelectedIndex: Int = -1
    var tapPosition: CGPoint = CGPoint()
    var score = 0
    
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var deckOfCards: deckOfCardsView!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: deckOfCards)
            tapPosition = position
            print(position)
        }
    }
    
    @IBAction func tapOnCard(_ sender: UITapGestureRecognizer) {

        switch sender.state {
        case .began, .ended:
            for i in 0..<deckOfCards.grid.cellCount {
                if deckOfCards.grid[i]!.contains(tapPosition) {
                    deckOfCards.game.cards[i].isSelected = !deckOfCards.game.cards[i].isSelected
                   lastSelectedIndex = i
                }
                //print(" deckOfCards.game.cards[\(i)].isSelected \(deckOfCards.game.cards[i].isSelected)")
            }
            
        default: break
        }
        
        checkIfMatched()
        
        deckOfCards.setNeedsLayout()
        deckOfCards.setNeedsDisplay()
    }
    
    func checkIfMatched() {
        switch selectedCardsNumber {
        case 1, 2 :
            print("cards selected indices without matching func: \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isSelected}))")

        case 3:
            print("cards selected indices after matching func: \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isSelected}))")
            print("cards VISIBLE indices before matching:  \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isVisible}))")
            if (deckOfCards.game.checkMatching()) {
                score += 3
                deckOfCards.grid.cellCount = (deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isVisible})).count
                print("match was made")
            }
            print("cards selected indices after matching func: \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isSelected}))")
            print("cards VISIBLE indices after matching:  \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isVisible}))\n")

        case 4:
            print("4 cards selected")
            print("cards selected indices before deselection: \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isSelected}))")
            print("cards VISIBLE indices before deselection:  \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isVisible}))\n")
            
            for i in 0..<deckOfCards.grid.cellCount {
                if lastSelectedIndex != i {
                   deckOfCards.game.cards[i].isSelected = false
                }
            }
            score -= 5

            print("cards selected indices after deselection: \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isSelected}))")
            print("cards VISIBLE indices after deselection:  \(deckOfCards.game.cards.indices.filter({deckOfCards.game.cards[$0].isVisible}))\n")
        default: return
        }
        updateButtonStatus()
        deckOfCards.setNeedsLayout()
        deckOfCards.setNeedsDisplay()
    }
    
    @IBOutlet weak var Deal3MoreCardsButton: UIButton!
    
    private func updateButtonStatus() {
        if add3MoreBtnIsActive {
            Deal3MoreCardsButton.isEnabled = true
            Deal3MoreCardsButton.setTitleColor(UIColor.green, for: UIControl.State.normal)

        }else {
            Deal3MoreCardsButton.isEnabled = false
            Deal3MoreCardsButton.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        }
        
        ScoreLabel.text = String("Score: \(score)")
    }

    @IBAction func Deal3MoreCards(_ sender: UIButton) {

        let count = deckOfCards.grid.cellCount
        deckOfCards.game.cards[count].isVisible = true
        deckOfCards.game.cards[count+1].isVisible = true
        deckOfCards.game.cards[count+2].isVisible = true
        deckOfCards.grid.cellCount += 3
        updateButtonStatus()
        
        deckOfCards.setNeedsLayout()
        deckOfCards.setNeedsDisplay()

    }

    @IBAction func NewGameBtn(_ sender: UIButton) {
        
        deckOfCards.grid = Grid(layout: Grid.Layout.aspectRatio(CGFloat(0.625)))
        deckOfCards.game = Game()
        
        score = 0
        lastSelectedIndex = -1
        tapPosition = CGPoint()
        
        updateButtonStatus()
        deckOfCards.setNeedsLayout()
        deckOfCards.setNeedsDisplay()
    }

}

