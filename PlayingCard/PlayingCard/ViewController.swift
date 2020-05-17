//
//  ViewController.swift
//  PlayingCard
//
//  Created by Deepankar D on 16/05/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    override func viewDidLoad() {
        super.viewDidLoad()
//         Do any additional setup after loading the view.
        
        for _ in 1...52{
            if let card = deck.draw(){
                print(card)
            }
            
        }
    }


}

