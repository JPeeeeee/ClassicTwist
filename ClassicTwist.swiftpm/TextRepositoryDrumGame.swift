//
//  TextRepositoryDrumGame.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 16/04/23.
//

import Foundation

class TextRepositoryDrumGame {
    private var index: Int = 0
    private let texts = [
        TextModel(title: "onGoing", content: "Hey!"),
        TextModel(title: "onGoing", content: "Looks like you did it!"),
        TextModel(title: "onGoing", content: "The drums are responsable for the whole rhythm of the song."),
        TextModel(title: "onGoing", content: "They are very, very important!"),
        TextModel(title: "onGoing", content: "Thank you, so much!"),
        TextModel(title: "onGoing", content: "But... the guitar is still broken..."),
        TextModel(title: "End", content: "Let's see what we can do!"),
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
