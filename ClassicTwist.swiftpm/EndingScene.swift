//
//  EndingScene.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 19/04/23.
//
import SpriteKit


class EndingScene: SKScene {
    
    private var cortina: SKSpriteNode!
    private var cortina_em_cima: SKSpriteNode!
    private var palco: SKSpriteNode!
    
    private var violao: SKSpriteNode!
    private var bateria: SKSpriteNode!
    
    private var villa_lobos: SKSpriteNode!
    
    private var text_box: SKSpriteNode!
    private var text_label: SKLabelNode!
    private var text_next_indicator: SKSpriteNode!
    

    
    private var text_model: TextModel!
    
    private let textRepository = TextRepositoryEndingScene()
    
    private var soundManager = SoundManager()
    
    private var flag_button: Int = 1
    
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
        text_box.position = CGPoint(x: frame.width * 0.65, y: frame.midY * 0.35)
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
        
        text_box.run(animations(animation_type: "fadeInWithWait", node: text_box))
        text_box.run(animations(animation_type: "showAndBounce", node: text_box))
        text_label.run(animations(animation_type: "fadeInWithWait", node: nil))
        text_next_indicator.run(SKAction.sequence([SKAction.wait(forDuration: 1), animations(animation_type: "fadeInNextIndicator", node: text_next_indicator)]))
        text_next_indicator.run(animations(animation_type: "bounce", node: text_next_indicator))
    }
    
    private func setup_stage () {
        
        violao = SKSpriteNode(imageNamed: "violaoFixed")
        violao.size = CGSize(width: violao.size.width * 0.6, height: violao.size.height * 0.6)
        violao.position = CGPoint(x: palco.frame.maxX * 0.35, y: palco.frame.midY * 1.1)
        violao.zPosition = 1
        
        bateria = SKSpriteNode(imageNamed: "bateriaFixed")
        bateria.size = CGSize(width: bateria.size.width * 0.6, height: bateria.size.height * 0.6)
        bateria.position = CGPoint(x: frame.maxX * 0.7, y: frame.midY * 1.05)
        bateria.zPosition = 1
        
        addChild(violao)
        addChild(bateria)
        
        violao.run(animations(animation_type: "bounceViolao", node: violao))
        bateria.run(animations(animation_type: "bounceDrums", node: bateria))
    }
    
    override func didMove(to view: SKView) {

        
        cortina_em_cima = SKSpriteNode(texture: SKTexture(imageNamed: "cortinaEmCima"), size: CGSize(width: frame.width, height: 120))
        cortina_em_cima.position = CGPoint(x: frame.midX, y: frame.maxY - 40)
        cortina_em_cima.zPosition = 4
        
        palco = SKSpriteNode(texture: SKTexture(imageNamed: "palco"), size: CGSize(width: frame.width, height: frame.height))
        palco.position = CGPoint(x: frame.midX, y: frame.midY)
        palco.zPosition = 0
        
        villa_lobos = SKSpriteNode(imageNamed: "parado1")
        villa_lobos.size = CGSize(width: villa_lobos.size.width / 3, height: villa_lobos.size.height / 3)
        villa_lobos.position = CGPoint(x: frame.width * 0.20, y: frame.height * 0.16)
        villa_lobos.zPosition = 2

        setup_stage()
        
        addChild(cortina_em_cima)
        addChild(palco)
        addChild(villa_lobos)
        
        execute_animation(texturePrefix: "parado")
        create_text_box()
    }
    

    
    func execute_animation(texturePrefix: String) {
        let textures = Array(1...9).map { number in
            return SKTexture(imageNamed: "\(texturePrefix)\(number)")
        }
        
        villa_lobos.run(
            .repeatForever(.animate(with: textures, timePerFrame: 0.3))
        )
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        if text_box != nil && text_box.contains(location) {
            
            let last_model_title = text_model.title

            if text_model.title != "End" {
                text_label.attributedText = setup_text()
                text_next_indicator.removeFromParent()
                text_next_indicator.alpha = 0
                addChild(text_next_indicator)
                switch text_model.title {
                case "Curtindo":
                    if (last_model_title != "Curtindo"){
                        execute_animation(texturePrefix: "curtindo")
                    }
                case "Assustado":
                    if (last_model_title != "Assustado"){
                        execute_animation(texturePrefix: "assustado")
                    }
                case "Parado":
                    if (last_model_title != "Parado"){
                        execute_animation(texturePrefix: "parado")
                    }
                default:
                    if (last_model_title != "Parado"){
                        execute_animation(texturePrefix: "parado")
                    }
                }
                
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
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let transition_close_curtain = SKTransition.doorsCloseHorizontal(withDuration: 1.5)
                    let newScene = CurtainTransitionScene()
                    newScene.set(newScene: FinalActScene())
                    newScene.size = CGSize(width: 1366, height: 1024)
                    newScene.scaleMode = .aspectFit
                    
                    self.soundManager.play(sound: .correiaCortina)
                    
                    self.scene?.view?.presentScene(newScene, transition: transition_close_curtain)
                }
            }
        }
    }
}
    
