//
//  ViewController.swift
//  Stanford - Memory Game
//
//  Created by Rodrigo Torres on 31/01/2021.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numbersOfPairsOfCards: (cardButtons.count + 1) / 2)

    var flipCount = 0 { didSet { flipCountLabel.text = "Flips : \(flipCount)" } }
    
    @IBOutlet weak var flipCountLabel : UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card was no in CardButtons")
        }
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                print()
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.9508606791, green: 0.1432128251, blue: 0, alpha: 1)
            }
        }
    }
    

    var emojiChoices = ["👺","👻","🕶","🎩","💍","💼"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let ramdomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: ramdomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

}

