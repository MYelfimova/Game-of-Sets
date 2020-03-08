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
        // Do any additional setup after loading the view.
        updateViewFromModel()
    }

    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        let button = sender
        button.layer.borderWidth = button.layer.borderWidth == 3.0 ? 0 : 3.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = button.layer.cornerRadius == 8.0 ? 0 : 8.0
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
