//
//  TextRepository.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 11/04/23.
//

import Foundation

class TextRepository {
    private var index: Int = 0
    private let texts = [
        TextModel(title: "Parado", content: "Hello there! I'm glad to see you here!"),
        TextModel(title: "Parado", content: "I'm Heitor Villa-Lobos and i'm going to be conducting the orchestra tonight!"),
        TextModel(title: "Parado", content: "Seems to me that you would like to hear a wonderful concert..."),
        TextModel(title: "Parado", content: "Just like i do, right?"),
        TextModel(title: "Parado", content: "Well, sit down and enjoy!"),
        TextModel(title: "Parado", content: "But..."),
        TextModel(title: "Assustado", content: "Wait!!!"),
        TextModel(title: "Assustado", content: "What happened?!?"),
        TextModel(title: "Assustado", content: "All my instruments!"),
        TextModel(title: "Assustado", content: "They are..."),
        TextModel(title: "Assustado", content: "BROKEN!!!"),
        TextModel(title: "Assustado", content: "My concert is starting soon..."),
        TextModel(title: "Assustado", content: "We have..."),
        TextModel(title: "Assustado", content: "THREE minutes!!!"),
        TextModel(title: "Assustado", content: "Can you help me fix them?"),
        TextModel(title: "Parado", content: "Yes?"),
        TextModel(title: "End", content: "Let's start with the drums then"),
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
