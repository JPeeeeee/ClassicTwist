//
//  TextRepositoryGuitarGame.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 17/04/23.
//

import Foundation

class TextRepositoryGuitarGame {
    private var index_database1: Int = 0
    private var database: Int = 0
    private var index_database2: Int = 0
    private var index_database3: Int = 0
    private var texts = [TextModel]()
    
    private var text_database1 = [
        TextModel(title: "onGoing", content: "The guitar is the most important part of my concert"),
        TextModel(title: "onGoing", content: "It is the instrument that gives the melody a wonderful taste"),
        TextModel(title: "onGoing", content: "Hmm..."),
        TextModel(title: "onGoing", content: "It doesn't seem to be broken..."),
        TextModel(title: "onGoing", content: "But the tuning..."),
        TextModel(title: "onGoing", content: "Yes!"),
        TextModel(title: "onGoing", content: "It's way off tune!"),
        TextModel(title: "End", content: "Let's try and fix that")
    ]
    
    private var text_database2 = [
        TextModel(title: "onGoing", content: "Well done!"),
        TextModel(title: "End", content: "Now, we need to do this with the other five!"),
    ]
    
    private var text_database3 = [
        TextModel(title: "onGoing", content: "Great!"),
        TextModel(title: "onGoing", content: "They are all in tune now!"),
        TextModel(title: "End", content: "You can go back to your seat if you want!")
    ]
    
    func set_text_database (text_database: Int) {
        switch text_database {
        case 1:
            texts = text_database1
            database = 1
        case 2:
            texts = text_database2
            database = 2
        case 3:
            texts = text_database3
            database = 3
        default:
            break
        }
    }
    
    func getNextText() -> TextModel {
        switch database {
        case 1:
            if index_database1 >= texts.count {
                return TextModel(title: "End", content: "Fora do indice!")
            }
            
            let text = texts[index_database1]
            index_database1 += 1
            
            return text
        case 2:
            if index_database2 >= texts.count {
                return TextModel(title: "End", content: "Fora do indice!")
            }
            
            let text = texts[index_database2]
            index_database2 += 1
            
            return text
        case 3:
            if index_database3 >= texts.count {
                return TextModel(title: "End", content: "Fora do indice!")
            }
            
            let text = texts[index_database3]
            index_database3 += 1
            
            return text
        default:
            break
        }
        
        return TextModel(title: "End", content: "Fora do indice!")
    }
}
