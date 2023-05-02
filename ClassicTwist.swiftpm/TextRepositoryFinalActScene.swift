//
//  TextRepositoryFinalActScene.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 19/04/23.
//

import Foundation

class TextRepositoryFinalActScene {
    private var index: Int = 0
    private let texts = [
        TextModel(title: "onGoing", content: "Now..."),
        TextModel(title: "onGoing", content: "This next song is dedicated to a very important person"),
        TextModel(title: "onGoing", content: "Who helped me get this concert back on track"),
        TextModel(title: "onGoing", content: "The song is called..."),
        TextModel(title: "End", content: "Choro n˚1"),
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
