//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Deepankar D on 16/05/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import Foundation

struct PlayingCardDeck{
    private(set) var cards = [PlayingCard]()
    
    init(){
        for suit in PlayingCard.Suit.all{
            for rank in PlayingCard.Rank.all{
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
    mutating func draw() -> PlayingCard? {
     //   print(cards.count)
        if cards.count > 0{
            return cards.remove(at: cards.count.arc4random)
        }else{
            return nil
        }
    }
    
    
    
}

//MARK: - Simplifying the statement of generating random index for emojis

extension Int{
    var arc4random : Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        }else{
            return 0
        }
    }
}
