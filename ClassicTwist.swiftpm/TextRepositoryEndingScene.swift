//
//  TextRepositoryDrumGame.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 19/04/23.
//

import Foundation

class TextRepositoryEndingScene {
    private var index: Int = 0
    private let texts = [
        TextModel(title: "onGoing", content: "Well..."),
        TextModel(title: "onGoing", content: "Would you look at that!"),
        TextModel(title: "onGoing", content: "We really did it!"),
        TextModel(title: "onGoing", content: "Actually..."),
        TextModel(title: "onGoing", content: "YOU!"),
        TextModel(title: "onGoing", content: "You did it!"),
        TextModel(title: "onGoing", content: "I wish i could give you something back..."),
        TextModel(title: "onGoing", content: "Hmm..."),
        TextModel(title: "onGoing", content: "You enjoy the concert..."),
        TextModel(title: "onGoing", content: "I will think of something..."),
        TextModel(title: "End", content: "Maybe if i..."),
    ]
    
    func getNextText() -> TextModel {
        if index >= texts.count {
            return TextModel(title: "Parado", content: "Fora do indice!")
        }
        
        let text = texts[index]
        index += 1
        
        return text
    }
}
