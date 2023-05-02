//
//  FinalActScene.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 19/04/23.
//

import SpriteKit

class FinalActScene: SKScene {
    private var palco: SKSpriteNode!
    private var crowd: SKSpriteNode!
    
    private var villa_lobos: SKSpriteNode!
    private var palanquete: SKSpriteNode!
    
    private var text_box: SKSpriteNode!
    private var text_label: SKLabelNode!
    private var text_next_indicator: SKSpriteNode!
    
    private var soundManager = SoundManager()
    
    private var text_model: TextModel!
    
    private let textRepository = TextRepositoryFinalActScene()
    
    private var flag_running = 0
    
    func set_sound(music: SoundManager) {
        self.soundManager = music
    }
    
    private func animations(animation_type: String, node: SKSpriteNode?) -> SKAction {
        let animation: SKAction!
        
        switch animation_type {
        case "bounce":
            let bounce = SKAction.sequence([SKAction.moveTo(y: (node?.position.y)! + 5, duration: 0.5), SKAction.moveTo(y: (node?.position.y)! - 5, duration: 0.5)])
            bounce.timingMode = .easeIn
            let bouncing_forever = SKAction.repeatForever(bounce)
            animation = bouncing_forever
        case "bounceDrums":
            let bounce = SKAction.sequence([SKAction.moveTo(y: (node?.position.y)! + 5, duration: 1), SKAction.moveTo(y: (node?.position.y)! - 5, duration: 1)])
            bounce.timingMode = .easeInEaseOut
            let bouncing_drums = SKAction.repeatForever(bounce)
            animation = bouncing_drums
        case "bounceViolao":
            let bounce = SKAction.sequence([SKAction.moveTo(y: (node?.position.y)! + 7, duration: 1.2), SKAction.moveTo(y: (node?.position.y)! - 7, duration: 1.2)])
            bounce.timingMode = .easeInEaseOut
            let bouncing_violao = SKAction.repeatForever(bounce)
            animation = bouncing_violao
        case "fadeInWithWait":
            let fade_in_with_wait = SKAction.sequence([SKAction.wait(forDuration: 1.2), SKAction.fadeIn(withDuration: 0.4)])
            animation = fade_in_with_wait
        case "fadeIn":
            let fade_in = SKAction.sequence([SKAction.fadeIn(withDuration: 0.4)])
            animation = fade_in
        case "fadeInNextIndicator":
            let fade_in_next_indicator = SKAction.sequence([SKAction.wait(forDuration: 1), SKAction.fadeIn(withDuration: 0.2)])
            animation = fade_in_next_indicator
        case "showAndBounce":
            let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
            let scale_back = SKAction.scale(to: 1, duration: 0.2)
            let show_and_bounce = SKAction.sequence([SKAction.wait(forDuration: 1.2), scale_animation, scale_back])
            animation = show_and_bounce
        case "textBoxBounce":
            let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
            let scale_back = SKAction.scale(to: 1, duration: 0.2)
            let textBoxBounce = SKAction.sequence([scale_animation, scale_back])
            animation = textBoxBounce
        case "moveLeft":
            let move_left = SKAction.moveBy(x: -frame.width, y: 0, duration: 1.5)
            animation = move_left
        case "buttonCircleOfLife":
            let the_button_circle_of_life = SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.removeFromParent(), SKAction.moveBy(x: -frame.width, y: frame.midY, duration: 0)])
            animation = the_button_circle_of_life
        case "scaleButton":
            let scale_button = SKAction.scale(to: 1.2, duration: 0.2)
            animation = scale_button
        case "fadeOut":
            let fade_out = SKAction.fadeOut(withDuration: 0.2)
            animation = fade_out
        default :
            animation = nil
            return animation
        }
        
        return animation
    }
    
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
        text_box.position = CGPoint(x: frame.width * 0.35, y: frame.midY * 0.35)
        text_box.zPosition = 4
        text_box.alpha = 0
        
        text_label = SKLabelNode()
        text_label.attributedText = setup_text()
        text_label.preferredMaxLayoutWidth = text_box.frame.width - 256
        text_label.numberOfLines = -1
        text_label.position = CGPoint(x: text_box.frame.midX, y: text_box.frame.maxY * 0.5)
        text_label.zPosition = 4
        text_label.alpha = 0
        
        text_next_indicator = SKSpriteNode(imageNamed: "arrowNext")
        text_next_indicator.size = CGSize(width: text_next_indicator.size.width / 6, height: text_next_indicator.size.height / 6)
        text_next_indicator.position = CGPoint(x: text_box.frame.maxX * 0.9, y: text_box.frame.height * 0.35)
        text_next_indicator.zPosition = 4
        text_next_indicator.alpha = 0
        
        addChild(text_box)
        addChild(text_label)
        addChild(text_next_indicator)
        
        text_box.run(animations(animation_type: "fadeInWithWait", node: text_box))
        text_box.run(animations(animation_type: "showAndBounce", node: text_box))
        text_label.run(animations(animation_type: "fadeInWithWait", node: nil))
        text_next_indicator.run(SKAction.sequence([SKAction.wait(forDuration: 1), animations(animation_type: "fadeInNextIndicator", node: text_next_indicator)]))
        text_next_indicator.run(animations(animation_type: "bounce", node: text_next_indicator))
    }
    
    override func didMove(to view: SKView) {
        palco = SKSpriteNode(texture: SKTexture(imageNamed: "palcoFinalScene"), size: CGSize(width: frame.width, height: frame.height))
        palco.position = CGPoint(x: frame.midX, y: frame.midY)
        palco.zPosition = -1
        
        crowd = SKSpriteNode(imageNamed: "crowd")
        crowd.size = CGSize(width: crowd.size.width * 0.5, height: crowd.size.height * 0.5)
        crowd.position = CGPoint(x: frame.midX, y: frame.minY + crowd.size.height * 0.5)
        crowd.zPosition = 2

        
        villa_lobos = SKSpriteNode(imageNamed: "tocando1")
        villa_lobos.size = CGSize(width: villa_lobos.size.width * 0.3, height: villa_lobos.size.height * 0.3)
        villa_lobos.position = CGPoint(x: frame.midX, y: frame.midY * 1.1)
        villa_lobos.zPosition = 0
        villa_lobos.alpha = 0

        self.soundManager.playLoop(sound: .falaPlateia)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.create_text_box()
        }
        
        addChild(palco)
        addChild(crowd)
        addChild(villa_lobos)
    }
    
    func execute_animation(texturePrefix: String) {
        let textures = Array(1...9).map { number in
            return SKTexture(imageNamed: "\(texturePrefix)\(number)")
        }
        
        villa_lobos.run(
            .repeatForever(.animate(with: textures, timePerFrame: 0.3))
        )
        
        villa_lobos.run(animations(animation_type: "bounceDrums", node: villa_lobos))
    }
    
    private func run_last_scene () {
        
        if flag_running != 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.palco.texture = SKTexture(imageNamed: "palcoFinalSceneLightsOff")
                
                self.soundManager.stop(sound: .falaPlateia)
                self.soundManager.play(sound: .luxMaxima)
                
                SoundManager.backgroundManager.stop(sound: .backgroundMusic)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.palco.texture = SKTexture(imageNamed: "palcoFinalSceneLightsOn")
                
                self.soundManager.play(sound: .luxMaxima)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                self.villa_lobos.run(SKAction.fadeIn(withDuration: 0.5))
                self.villa_lobos.run(SKAction.sequence([SKAction.scale(to: 1.2, duration: 0.2), SKAction.scale(to: 1, duration: 0.2)]))
                self.execute_animation(texturePrefix: "tocando")
                
                self.soundManager.play(sound: .choron1)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 36) {
                let transition_close_curtain = SKTransition.doorsCloseHorizontal(withDuration: 1.5)
                let newScene = AndScene()
                newScene.size = CGSize(width: 1366, height: 1024)
                newScene.scaleMode = .aspectFit
                
                self.scene?.view?.presentScene(newScene, transition: transition_close_curtain)

            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        if text_box != nil && text_box.contains(location) {
            
            if text_model.title != "End" {
                text_label.attributedText = setup_text()
                text_next_indicator.removeFromParent()
                text_next_indicator.alpha = 0
                
                addChild(text_next_indicator)
                
                text_box.run(animations(animation_type: "fadeInWithWait", node: text_box))
                text_box.run(animations(animation_type: "textBoxBounce", node: text_box))
                text_label.run(animations(animation_type: "fadeIn", node: nil))
                text_label.run(animations(animation_type: "textBoxBounce", node: nil))
                text_next_indicator.run(animations(animation_type: "fadeInNextIndicator", node: text_next_indicator))
                text_next_indicator.run(animations(animation_type: "bounce", node: text_next_indicator))
            } else {
                text_next_indicator.removeFromParent()
                text_box.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
                text_label.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
                
                run_last_scene()
                flag_running = 1
            }
        }
    }
}
