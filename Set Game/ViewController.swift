//
//  ViewController.swift
//  Set Game
//
//  Created by Maria Yelfimova on 3/2/20.
//  Copyright © 2020 Maria Yelfimova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //var game = Game()
           
        //print(game.cards)
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
    
    
}
