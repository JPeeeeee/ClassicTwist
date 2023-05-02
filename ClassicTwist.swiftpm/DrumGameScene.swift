//
//  DrumGameScene.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 13/04/23.
//

import SpriteKit

enum node_drag {
    case Prato1, Prato2, Tambor, Nothing
}

class DrumGameScene: SKScene {

    private var arrastando: SKSpriteNode?
    
    private var bateria: SKSpriteNode!
    private var prato1: SKSpriteNode!
    private var prato2: SKSpriteNode!
    private var tambor: SKSpriteNode!
    private var palco: SKSpriteNode!
    private var piecesHolder: SKSpriteNode!
    
    private var placeholderPrato1: SKSpriteNode!
    private var placeholderPrato2: SKSpriteNode!
    private var placeholderTambor: SKSpriteNode!
    
    private var bateriaPrato1: SKSpriteNode!
    private var bateriaPrato2: SKSpriteNode!
    private var bateriaPrato1Prato2: SKSpriteNode!
    private var bateriaPrato1Tambor: SKSpriteNode!
    private var bateriaPrato2Tambor: SKSpriteNode!
    private var bateriaFixed : SKSpriteNode!
    
    private var flag_prato1_fixed: Int = 0
    private var flag_prato2_fixed: Int = 0
    private var flag_tambor_fixed: Int = 0
    
    private var flag_node: node_drag = node_drag.Nothing
    
    private var text_box: SKSpriteNode!
    private var text_label: SKLabelNode!
    private var text_next_indicator: SKSpriteNode!
    
    private var text_model: TextModel!
    private let textRepository = TextRepositoryDrumGame()
    
    private var button_guitar: SKSpriteNode!
    
    private var soundManager = SoundManager()
    
    private func setup_text () -> NSAttributedString {
        
        text_model = textRepository.getNextText()
        
        let attrString = NSMutableAttributedString(string: text_model.content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text_model.content.count)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .bold)], range: range)
        
        return attrString
    }
    
    private func create_text_box() {
        
        text_box = SKSpriteNode(imageNamed: "textBox")
        text_box.size = CGSize(width: text_box.size.width * 1.3, height: text_box.size.height)
        text_box.position = CGPoint(x: frame.width * 0.30, y: frame.midY * 0.35)
        text_box.zPosition = 1
        text_box.alpha = 0
        
        text_label = SKLabelNode()
        text_label.attributedText = setup_text()
        text_label.preferredMaxLayoutWidth = text_box.frame.width - 256
        text_label.numberOfLines = -1
        text_label.position = CGPoint(x: text_box.frame.midX, y: text_box.frame.maxY * 0.5)
        text_label.zPosition = 2
        text_label.alpha = 0
        
        text_next_indicator = SKSpriteNode(imageNamed: "arrowNext")
        text_next_indicator.size = CGSize(width: text_next_indicator.size.width / 6, height: text_next_indicator.size.height / 6)
        text_next_indicator.position = CGPoint(x: text_box.frame.maxX * 0.9, y: text_box.frame.height * 0.35)
        text_next_indicator.zPosition = 3
        text_next_indicator.alpha = 0
        
        addChild(text_label)
        addChild(text_box)
        addChild(text_next_indicator)
        
        let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
        let scale_back = SKAction.scale(to: 1, duration: 0.2)
        let show_and_bounce = SKAction.sequence([SKAction.wait(forDuration: 1.2), scale_animation, scale_back])
        
        let fade_in_next_indicator = SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.fadeIn(withDuration: 0.2)])
        
        let bounce = SKAction.sequence([SKAction.moveTo(y: text_next_indicator.position.y + 5, duration: 0.5), SKAction.moveTo(y: text_next_indicator.position.y - 5, duration: 0.5)])
        let bouncing_forever = SKAction.repeatForever(bounce)
        
        let fade_in_with_wait = SKAction.sequence([SKAction.wait(forDuration: 1.2), SKAction.fadeIn(withDuration: 0.4)])
        
        let fade_out_pieces_holder = SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()])
        
        piecesHolder.run(fade_out_pieces_holder)
        text_box.run(fade_in_with_wait)
        text_box.run(show_and_bounce)
        text_label.run(fade_in_with_wait)
        text_next_indicator.run(fade_in_next_indicator)
        text_next_indicator.run(bouncing_forever)
    }
    

    override func didMove(to view: SKView) {
        

        
        bateria = SKSpriteNode(imageNamed: "bateriaBrokenMinigame")
        bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
        bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
        bateria.zPosition = 1
        
        piecesHolder = SKSpriteNode(imageNamed: "piecesHolder")
        piecesHolder.size = CGSize(width: piecesHolder.size.width, height: piecesHolder.size.height)
        piecesHolder.position = CGPoint(x: frame.midX, y: frame.midY * 0.25)
        piecesHolder.zPosition = 1
        
        prato1 = SKSpriteNode(imageNamed: "prato1")
        prato1.size = CGSize(width: prato1.size.width * 1.3, height: prato1.size.height * 1.3)
        prato1.position = CGPoint(x: frame.midX * 0.5, y: frame.midY * 0.25)
        prato1.zPosition = 2
        
        prato2 = SKSpriteNode(imageNamed: "prato2")
        prato2.size = CGSize(width: prato2.size.width * 0.5, height: prato2.size.height * 0.5)
        prato2.position = CGPoint(x: frame.midX, y: frame.midY * 0.25)
        prato2.zPosition = 2
        
        tambor = SKSpriteNode(imageNamed: "tambor")
        tambor.size = CGSize(width: tambor.size.width, height: tambor.size.height)
        tambor.position = CGPoint(x: frame.midX * 1.5, y: frame.midY * 0.25)
        tambor.zPosition = 2
        
        placeholderPrato1 = SKSpriteNode(imageNamed: "placeholderPrato1")
        placeholderPrato1.size = CGSize(width: placeholderPrato1.size.width * 0.35, height: placeholderPrato1.size.height * 0.35)
        placeholderPrato1.position = CGPoint(x: frame.midX * 0.65, y: frame.midY * 1.2)
        placeholderPrato1.zPosition = 0
        placeholderPrato1.alpha = 0.5
        
        placeholderPrato2 = SKSpriteNode(imageNamed: "placeholderPrato2")
        placeholderPrato2.size = CGSize(width: placeholderPrato2.size.width * 0.35, height: placeholderPrato2.size.height * 0.35)
        placeholderPrato2.position = CGPoint(x: frame.midX * 1.35, y: frame.midY * 1.2)
        placeholderPrato2.zPosition = 0
        placeholderPrato2.alpha = 0.5
        
        placeholderTambor = SKSpriteNode(imageNamed: "tambor")
        placeholderTambor.size = CGSize(width: tambor.size.width, height: tambor.size.height)
        placeholderTambor.position = CGPoint(x: frame.midX * 1.1, y: frame.midY * 1.1)
        placeholderTambor.zPosition = 0
        placeholderTambor.alpha = 0.5
        
        palco = SKSpriteNode(texture: SKTexture(imageNamed: "palcoMinigameBateria"), size: CGSize(width: frame.width, height: frame.height))
        palco.position = CGPoint(x: frame.midX, y: frame.midY)
        palco.zPosition = -1
        
        let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
        let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
        
        let bounce_prato1 = SKAction.sequence([SKAction.moveTo(y: placeholderPrato1.position.y + 5, duration: 1), SKAction.moveTo(y: placeholderPrato1.position.y - 5, duration: 1)])
        let bouncing_forever_prato1 = SKAction.repeatForever(bounce_prato1)
        
        let bounce_prato2 = SKAction.sequence([SKAction.moveTo(y: placeholderPrato2.position.y + 5, duration: 1), SKAction.moveTo(y: placeholderPrato2.position.y - 5, duration: 1)])
        let bouncing_forever_prato2 = SKAction.repeatForever(bounce_prato2)
        
        let bounce_tambor = SKAction.sequence([SKAction.moveTo(y: placeholderTambor.position.y + 5, duration: 1), SKAction.moveTo(y: placeholderTambor.position.y - 5, duration: 1)])
        let bouncing_forever_tambor = SKAction.repeatForever(bounce_tambor)
        
        bateria.run(bouncing_forever_drum)
        placeholderPrato1.run(bouncing_forever_prato1)
        placeholderPrato2.run(bouncing_forever_prato2)
        placeholderTambor.run(bouncing_forever_tambor)
        
        addChild(piecesHolder)
        addChild(placeholderPrato1)
        addChild(placeholderPrato2)
        addChild(placeholderTambor)
        addChild(palco)
        addChild(prato1)
        addChild(prato2)
        addChild(tambor)
        addChild(bateria)
    }
    
    func set_soundplayer (newSoundManager: SoundManager) {
        soundManager = newSoundManager
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        let scale_animation = SKAction.scale(by: 1.2, duration: 0.2)

        if prato1.contains(location) {
            arrastando = prato1
            flag_node = node_drag.Prato1
            self.soundManager.play(sound: .prato1)
        } else if prato2.contains(location){
            arrastando = prato2
            flag_node = node_drag.Prato2
            self.soundManager.play(sound: .prato2)
        } else if tambor.contains(location){
            arrastando = tambor
            flag_node = node_drag.Tambor
            self.soundManager.play(sound: .tambor)
        }
        
        arrastando?.run(scale_animation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        if arrastando != nil {
            arrastando?.position = location
        }
    }
    
    private func help_button () {
        button_guitar = SKSpriteNode(imageNamed: "buttonGuitar")
        button_guitar.size = CGSize(width: button_guitar.size.width, height: button_guitar.size.height)
        button_guitar.position = CGPoint(x: frame.midX, y: text_box.frame.midY)
        button_guitar.zPosition = 3
        button_guitar.alpha = 0
        addChild(button_guitar)
        button_guitar.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeIn(withDuration: 0.5)]))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let scale_animation_back = SKAction.scale(to: 1, duration: 0.2)
        arrastando?.run(scale_animation_back)
        
        
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        switch flag_node {
        case .Prato1:
            if placeholderPrato1.contains(location) && flag_tambor_fixed == 0 && flag_prato2_fixed == 0 {
                bateria.removeFromParent()
                placeholderPrato1.removeFromParent()
                prato1.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaPrato1")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_prato1_fixed = 1
                
            } else if placeholderPrato1.contains(location) && flag_tambor_fixed != 0 && flag_prato2_fixed == 0{
                bateria.removeFromParent()
                placeholderPrato1.removeFromParent()
                prato1.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaPrato1AndTambor")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_prato1_fixed = 1
                
            } else if placeholderPrato1.contains(location) && flag_tambor_fixed == 0 && flag_prato2_fixed != 0{
                bateria.removeFromParent()
                placeholderPrato1.removeFromParent()
                prato1.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaPrato1Prato2")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_prato1_fixed = 1
                
            } else if placeholderPrato1.contains(location) && flag_tambor_fixed != 0 && flag_prato2_fixed != 0{
                bateria.removeFromParent()
                placeholderPrato1.removeFromParent()
                prato1.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaFixed")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_prato1_fixed = 1
                
                create_text_box()
                
                self.soundManager.play(sound: .bateriaFixed)
            }
        case .Prato2:
            if placeholderPrato2.contains(location) && flag_tambor_fixed == 0 && flag_prato1_fixed == 0{
                bateria.removeFromParent()
                placeholderPrato2.removeFromParent()
                prato2.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaPrato2")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_prato2_fixed = 1
                
            } else if placeholderPrato2.contains(location) && flag_tambor_fixed != 0 && flag_prato1_fixed == 0{
                bateria.removeFromParent()
                placeholderPrato2.removeFromParent()
                prato2.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaPrato2AndTambor")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_prato2_fixed = 1
                
            } else if placeholderPrato2.contains(location) && flag_tambor_fixed == 0 && flag_prato1_fixed != 0{
                bateria.removeFromParent()
                placeholderPrato2.removeFromParent()
                prato2.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaPrato1Prato2")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_prato2_fixed = 1
                
            } else if placeholderPrato2.contains(location) && flag_tambor_fixed != 0 && flag_prato1_fixed != 0{
                bateria.removeFromParent()
                placeholderPrato2.removeFromParent()
                prato2.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaFixed")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_prato2_fixed = 1
                
                create_text_box()
                
                self.soundManager.play(sound: .bateriaFixed)
            }
        case .Tambor:
            if placeholderTambor.contains(location) && flag_prato1_fixed == 0 && flag_prato2_fixed == 0{
                bateria.removeFromParent()
                placeholderTambor.removeFromParent()
                tambor.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaTambor")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_tambor_fixed = 1
                
            } else if placeholderTambor.contains(location) && flag_prato1_fixed != 0 && flag_prato2_fixed == 0{
                bateria.removeFromParent()
                placeholderTambor.removeFromParent()
                tambor.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaPrato1AndTambor")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_tambor_fixed = 1
                
            } else if placeholderTambor.contains(location) && flag_prato1_fixed == 0 && flag_prato2_fixed != 0{
                bateria.removeFromParent()
                placeholderTambor.removeFromParent()
                tambor.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaPrato2AndTambor")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_tambor_fixed = 1
                
            } else if placeholderTambor.contains(location) && flag_prato1_fixed != 0 && flag_prato2_fixed != 0{
                bateria.removeFromParent()
                placeholderTambor.removeFromParent()
                tambor.removeFromParent()
                
                bateria = SKSpriteNode(imageNamed: "bateriaFixed")
                bateria.size = CGSize(width: bateria.size.width, height: bateria.size.height)
                bateria.position = CGPoint(x: frame.midX, y: frame.midY * 1.15)
                bateria.zPosition = 1

                let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
                let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
                bateria.run(bouncing_forever_drum)
                
                addChild(bateria)
                
                flag_node = node_drag.Nothing
                
                flag_tambor_fixed = 1
                
                create_text_box()
                
                self.soundManager.play(sound: .bateriaFixed)
            }
        default:
            break
        }
        
        flag_node = node_drag.Nothing
        
        let bounce_drum = SKAction.sequence([SKAction.moveTo(y: bateria.position.y + 5, duration: 1), SKAction.moveTo(y: bateria.position.y - 5, duration: 1)])
        let bouncing_forever_drum = SKAction.repeatForever(bounce_drum)
        
        let bounce_prato1 = SKAction.sequence([SKAction.moveTo(y: placeholderPrato1.position.y + 5, duration: 1), SKAction.moveTo(y: placeholderPrato1.position.y - 5, duration: 1)])
        let bouncing_forever_prato1 = SKAction.repeatForever(bounce_prato1)
        
        let bounce_prato2 = SKAction.sequence([SKAction.moveTo(y: placeholderPrato2.position.y + 5, duration: 1), SKAction.moveTo(y: placeholderPrato2.position.y - 5, duration: 1)])
        let bouncing_forever_prato2 = SKAction.repeatForever(bounce_prato2)
        
        let bounce_tambor = SKAction.sequence([SKAction.moveTo(y: placeholderTambor.position.y + 5, duration: 1), SKAction.moveTo(y: placeholderTambor.position.y - 5, duration: 1)])
        let bouncing_forever_tambor = SKAction.repeatForever(bounce_tambor)
        
        bateria.run(bouncing_forever_drum)
        placeholderPrato1.run(bouncing_forever_prato1)
        placeholderPrato2.run(bouncing_forever_prato2)
        placeholderTambor.run(bouncing_forever_tambor)
        
        arrastando = nil
        
        
        let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
        let scale_back = SKAction.scale(to: 1, duration: 0.2)
        let textBoxBounce = SKAction.sequence([scale_animation, scale_back])
        
        let fade_in_next_indicator = SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.fadeIn(withDuration: 0.2)])
        
        let fade_in_with_wait = SKAction.sequence([SKAction.wait(forDuration: 1.2), SKAction.fadeIn(withDuration: 0.4)])
        
        let fade_in = SKAction.sequence([SKAction.fadeIn(withDuration: 0.4)])
        

        if text_box != nil && text_box.contains(location){
            if text_model.title != "End" {
                text_label.attributedText = setup_text()
                text_label.alpha = 0
                text_next_indicator.alpha = 0

                let bounce = SKAction.sequence([SKAction.moveTo(y: text_next_indicator.position.y + 5, duration: 0.5), SKAction.moveTo(y: text_next_indicator.position.y - 5, duration: 0.5)])
                let bouncing_forever = SKAction.repeatForever(bounce)
                
                text_box.run(fade_in_with_wait)
                text_box.run(textBoxBounce)
                text_label.run(fade_in)
                text_label.run(textBoxBounce)
                text_next_indicator.run(fade_in_next_indicator)
                text_next_indicator.run(bouncing_forever)
                
            } else {
                text_next_indicator.removeFromParent()
                
                let fade_out = SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent(), SKAction.moveTo(x: -frame.width, duration: 0)])
                
                text_box.run(fade_out)
                text_label.run(fade_out)
                
                help_button()
            }
        } else if button_guitar != nil && button_guitar.contains(location) {
            let fade_out = SKAction.fadeOut(withDuration: 0.2)
            
            button_guitar.run(textBoxBounce)
            button_guitar.run(fade_out)
            
            let transition_close_curtain = SKTransition.doorsCloseHorizontal(withDuration: 1.5)
            let newScene = CurtainTransitionScene()
            newScene.set(newScene: GuitarGameScene())
            newScene.size = CGSize(width: 1366, height: 1024)
            newScene.scaleMode = .aspectFit
            
            soundManager.play(sound: .correiaCortina)
            
            scene?.view?.presentScene(newScene, transition: transition_close_curtain)
        }
    }
}
