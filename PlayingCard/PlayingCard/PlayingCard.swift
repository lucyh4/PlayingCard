//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Deepankar D on 16/05/20.
//  Copyright © 2020 Neha. All rights reserved.
//

import Foundation

struct PlayingCard : CustomStringConvertible{
    var description: String { return "\(rank)\(suit)"}
    var suit : Suit
    var rank : Rank
    
    
    
    
    enum Suit : CustomStringConvertible{
        var description: String{
            switch self {
            case .spades: return "♠️"
            case .clubs: return "♣️"
            case .hearts: return "♥️"
            case .diamonds: return "♦️"
                
            }
        }
//  or we can write just this line -> var description : String { return rawValue}
        case spades
        case clubs
        case hearts
        case diamonds
        static var all = [Suit.spades,.clubs,.hearts,.diamonds]
    }
    enum Rank : CustomStringConvertible{
        var description: String{
            switch self {
            case .ace: return "Ace"
            case .face(let kind): return kind
            case .numeric(let pips): return "\(pips)"
            }
        }
        
 
        
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int{
            switch self{
            case .ace: return 1
            case .face(let kind) where kind == "J": return 11
            case .face(let kind) where kind == "Q": return 12
            case .face(let kind) where kind == "K": return 13
            case .numeric(let pips): return pips
            default : return 0
            }
        }
        
        static var all : [Rank]{
            var allCard = [Rank.ace]
            for pip in 2...10{
                allCard.append(Rank.numeric(pip))
            }
            allCard += [Rank.face("J"),.face("Q"),.face("K")]
            //            allCard.append(Rank.face("J"))
            //            allCard.append(Rank.face("Q"))
            //            allCard.append(Rank.face("K"))
            return allCard
        }
    }
}
