//
//  FocusedGuitarGameScene.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 17/04/23.
//

import SpriteKit

class FocusedGuitarGameScene: SKScene {
    
    private var game_tutorial: SKSpriteNode!
    
    private var text_box: SKSpriteNode!
    private var text_label: SKLabelNode!
    private var text_next_indicator: SKSpriteNode!
    
    private var text_model: TextModel!
    private let textRepository = TextRepositoryGuitarGame()
    
    private var soundManager = SoundManager()
    
    private var palco: SKSpriteNode!
    private var violao: SKSpriteNode!
    
    private var afinador1: SKSpriteNode!
    private var afinador2: SKSpriteNode!
    private var afinador3: SKSpriteNode!
    private var afinador4: SKSpriteNode!
    private var afinador5: SKSpriteNode!
    private var afinador6: SKSpriteNode!
    
    private var pressure_button: SKSpriteNode!
    
    private var contador_cordas : Int = 1
    private var contador_arrastado: Int = 0
    private var pressure_regulator: SKSpriteNode!
    private var pressure_indicator: SKSpriteNode!
    private var green_area: SKSpriteNode!
    
    private var flag_clicked = 0
    private var numberOfTextDatabase = 1
    
    private func setup_text (textDatabase: Int) -> NSAttributedString {
        
        textRepository.set_text_database(text_database: textDatabase)
        text_model = textRepository.getNextText()
        
        let attrString = NSMutableAttributedString(string: text_model.content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        let range = NSRange(location: 0, length: text_model.content.count)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        attrString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .bold)], range: range)
        
        return attrString
    }
    
    private func create_text_box(textDatabase: Int) {
        
        text_box = SKSpriteNode(imageNamed: "textBox")
        text_box.size = CGSize(width: text_box.size.width * 1.3, height: text_box.size.height)
        text_box.position = CGPoint(x: frame.width * 0.30, y: frame.midY * 1.5)
        text_box.zPosition = 1
        text_box.alpha = 0
        
        addChild(text_box)
        
        text_label = SKLabelNode()
        text_label.attributedText = setup_text(textDatabase: textDatabase)
        text_label.preferredMaxLayoutWidth = text_box.frame.width - 256
        text_label.numberOfLines = -1
        text_label.position = CGPoint(x: text_box.frame.midX, y: text_box.frame.midY)
        text_label.zPosition = 2
        text_label.alpha = 0
        
        text_next_indicator = SKSpriteNode(imageNamed: "arrowNext")
        text_next_indicator.size = CGSize(width: text_next_indicator.size.width / 6, height: text_next_indicator.size.height / 6)
        text_next_indicator.position = CGPoint(x: text_box.frame.maxX * 0.9, y: text_box.frame.midY * 0.92)
        text_next_indicator.zPosition = 3
        text_next_indicator.alpha = 0
        
        addChild(text_label)
        addChild(text_next_indicator)
        
        let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
        let scale_back = SKAction.scale(to: 1, duration: 0.2)
        let show_and_bounce = SKAction.sequence([SKAction.wait(forDuration: 1), scale_animation, scale_back])
        
        let fade_in_next_indicator = SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.fadeIn(withDuration: 0.2)])
        
        let bounce = SKAction.sequence([SKAction.moveTo(y: text_next_indicator.position.y + 5, duration: 0.5), SKAction.moveTo(y: text_next_indicator.position.y - 5, duration: 0.5)])
        let bouncing_forever = SKAction.repeatForever(bounce)
        
        let fade_in_with_wait = SKAction.sequence([SKAction.wait(forDuration: 1.2), SKAction.fadeIn(withDuration: 0.4)])

        text_box.run(fade_in_with_wait)
        text_box.run(show_and_bounce)
        text_label.run(fade_in_with_wait)
        text_next_indicator.run(fade_in_next_indicator)
        text_next_indicator.run(bouncing_forever)
    }
    
    override func didMove(to view: SKView) {
        palco = SKSpriteNode(imageNamed: "palcoMinigameFocusedGuitar")
        palco.size = CGSize(width: frame.width, height: frame.height)
        palco.position = CGPoint(x: frame.midX, y: frame.midY)
        palco.zPosition = -1
        
        violao = SKSpriteNode(imageNamed: "violaoMinigame")
        violao.size = CGSize(width: violao.frame.width * 1.4, height: violao.frame.height * 1.4)
        violao.position = CGPoint(x: frame.minX + violao.frame.width * 0.75 / 2 , y: frame.midY * 0.6)
        violao.zPosition = 1
        
        afinador1 = SKSpriteNode(imageNamed: "afinadorGuitar")
        afinador1.size = CGSize(width: afinador1.frame.width * 1.2, height: afinador1.frame.height * 1.2)
        afinador1.position = CGPoint(x: violao.frame.midX * 1.35, y: violao.frame.midY * 1.4)
        afinador1.zPosition = 0
        
        afinador2 = SKSpriteNode(imageNamed: "afinadorGuitar")
        afinador2.size = CGSize(width: afinador2.frame.width * 1.2, height: afinador2.frame.height * 1.2)
        afinador2.position = CGPoint(x: violao.frame.midX * 1.55, y: violao.frame.midY * 1.42)
        afinador2.zPosition = 0
        
        afinador3 = SKSpriteNode(imageNamed: "afinadorGuitar")
        afinador3.size = CGSize(width: afinador3.frame.width * 1.2, height: afinador3.frame.height * 1.2)
        afinador3.position = CGPoint(x: violao.frame.midX * 1.75, y: violao.frame.midY * 1.45)
        afinador3.zPosition = 0
        
        afinador4 = SKSpriteNode(imageNamed: "afinadorGuitar")
        afinador4.size = CGSize(width: afinador4.frame.width * 1.2, height: afinador4.frame.height * 1.2)
        afinador4.position = CGPoint(x: violao.frame.midX * 1.35, y: violao.frame.midY * 0.49)
        afinador4.yScale = -1
        afinador4.zPosition = 0
        
        afinador5 = SKSpriteNode(imageNamed: "afinadorGuitar")
        afinador5.size = CGSize(width: afinador5.frame.width * 1.2, height: afinador5.frame.height * 1.2)
        afinador5.position = CGPoint(x: violao.frame.midX * 1.55, y: violao.frame.midY * 0.46)
        afinador5.yScale = -1
        afinador5.zPosition = 0
        
        afinador6 = SKSpriteNode(imageNamed: "afinadorGuitar")
        afinador6.size = CGSize(width: afinador6.frame.width * 1.2, height: afinador6.frame.height * 1.2)
        afinador6.position = CGPoint(x: violao.frame.midX * 1.75, y: violao.frame.midY * 0.44)
        afinador6.yScale = -1
        afinador6.zPosition = 0
        
        pressure_button = SKSpriteNode(imageNamed: "pressureButton")
        pressure_button.size = CGSize(width: pressure_button.size.width * 0.8, height: pressure_button.size.height * 0.8)
        pressure_button.position = CGPoint(x: frame.midX * 1.7, y: violao.frame.midY)
        pressure_button.zPosition = 0
        pressure_button.alpha = 0
        
        game_tutorial = SKSpriteNode(imageNamed: "guitarGameTutorial")
        game_tutorial.size = CGSize(width: game_tutorial.size.width * 1.1, height: game_tutorial.size.height * 1.1)
        game_tutorial.position = CGPoint(x: frame.midX, y: frame.midY * 1.65)
        game_tutorial.zPosition = 1
        game_tutorial.alpha = 0
        
        pressure_regulator = SKSpriteNode(imageNamed: "medidorGuitarGame")
        pressure_regulator.size = CGSize(width: pressure_regulator.size.width * 0.75, height: pressure_regulator.size.height * 0.65)
        pressure_regulator.position = CGPoint(x: frame.midX, y: frame.midY * 1.6)
        pressure_regulator.zPosition = 1
        pressure_regulator.alpha = 0
        
        pressure_indicator = SKSpriteNode(imageNamed: "pressureIndicator")
        pressure_indicator.size = CGSize(width: pressure_indicator.size.width * 0.65, height: pressure_indicator.size.height * 0.65)
        pressure_indicator.position = CGPoint(x: pressure_regulator.size.width * 0.35, y: pressure_regulator.frame.midY)
        pressure_indicator.zPosition = 2
        pressure_indicator.alpha = 0
        
        green_area = SKSpriteNode(imageNamed: "greenAreaGuitarGame")
        green_area.size = CGSize(width: green_area.size.width * 0.75, height: green_area.size.height * 0.65)
        green_area.position = CGPoint(x: pressure_regulator.size.width * 0.5 + CGFloat(pressure_regulator.size.width).truncatingRemainder(dividingBy: pressure_regulator.size.width - green_area.size.width), y: pressure_regulator.frame.midY * 1.01)
        green_area.zPosition = 1
        green_area.alpha = 0
        
        

        addChild(game_tutorial)
        addChild(palco)
        addChild(violao)
        addChild(afinador1)
        addChild(afinador2)
        addChild(afinador3)
        addChild(afinador4)
        addChild(afinador5)
        addChild(afinador6)
        addChild(pressure_button)
        addChild(pressure_regulator)
        addChild(pressure_indicator)
        addChild(green_area)
        
        numberOfTextDatabase = 1
        create_text_box(textDatabase: numberOfTextDatabase)
    }
    
    private func animate_afinador (node: SKSpriteNode?) -> SKAction {
        let bounce_animation = SKAction.sequence([SKAction.moveTo(y: (node?.position.y)! - 3, duration: 0.5), SKAction.moveTo(y: (node?.position.y)! + 3, duration: 0.5)])
        let bounce_afinador = SKAction.repeatForever(bounce_animation)
        bounce_afinador.timingMode = .easeInEaseOut
        
        return bounce_afinador
    }
    
    private func animate_afinador2 (node: SKSpriteNode?) -> SKAction {
        let bounce_animation = SKAction.sequence([SKAction.moveTo(y: (node?.position.y)! + 3, duration: 0.5), SKAction.moveTo(y: (node?.position.y)! - 3, duration: 0.5)])
        let bounce_afinador = SKAction.repeatForever(bounce_animation)
        bounce_afinador.timingMode = .easeInEaseOut
        
        return bounce_afinador
    }
  
    
    private func create_tuning_handler () {
        let fadeIn = SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.fadeIn(withDuration: 0.5)])

        
        pressure_regulator.run(fadeIn)
        pressure_indicator.run(fadeIn)
        green_area.run(fadeIn)
    }
    
    private func destroy_tuning_handler () {
        let fadeOut = SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.fadeOut(withDuration: 0.5)])
        
        pressure_regulator.run(fadeOut)
        pressure_indicator.run(fadeOut)
        green_area.run(fadeOut)
    }
    
    private func destroy_and_reapear_handler () {
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let fadeIn = SKAction.sequence([SKAction.wait(forDuration: 0.2), SKAction.fadeIn(withDuration: 0.5)])
        
        let max_width = pressure_regulator.size.width - green_area.size.width * 0.5
        let min_width = pressure_regulator.size.width * 0.5
        
        let new_green_area_position = SKAction.moveTo(x: CGFloat(Int.random(in: Int(min_width)...Int(max_width))), duration: 0)
        
        pressure_regulator.run(SKAction.sequence([fadeOut, fadeIn]))
        pressure_indicator.run(SKAction.sequence([fadeOut, fadeIn]))
        green_area.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), new_green_area_position]))
        green_area.run(SKAction.sequence([fadeOut, fadeIn]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let location = touch.location(in: self)
        
        if pressure_button != nil && pressure_button.contains(location) && pressure_button.alpha != 0 {
            pressure_button.run(SKAction.scale(to: 1.2, duration: 0.2))
            
            
            // Create the tuning handler after the first text boxes
            if numberOfTextDatabase == 1 {
                game_tutorial.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()]))
                create_tuning_handler()
            }
            
            flag_clicked = 1
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let location = touch.location(in: self)
        
        if pressure_button != nil && pressure_button.contains(location) && flag_clicked == 1 {
            print(contador_arrastado)

            contador_arrastado += 4

            pressure_indicator.run(SKAction.moveTo(x: (pressure_regulator.position.x + CGFloat(contador_arrastado)).truncatingRemainder(dividingBy: pressure_regulator.size.width - pressure_regulator.size.width * 0.35) + pressure_regulator.size.width * 0.35, duration: 0.1))
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }

        let location = touch.location(in: self)
        
        // rescale pressure_button to 1 and remove the flag clicked
        pressure_button.run(SKAction.scale(to: 1, duration: 0.2))
        pressure_indicator.run(SKAction.moveTo(x: pressure_regulator.size.width * 0.35, duration: 0.1))
        contador_arrastado = 0
        flag_clicked = 0
        
        if green_area.contains(pressure_indicator.position) {

            switch contador_cordas {
            case 1:
                afinador1.run(animate_afinador(node: afinador1))
                soundManager.play(sound: .corda6)
            case 2:
                afinador2.run(animate_afinador(node: afinador2))
                soundManager.play(sound: .corda5)
            case 3:
                afinador3.run(animate_afinador(node: afinador3))
                soundManager.play(sound: .corda4)
            case 4:
                afinador4.run(animate_afinador2(node: afinador4))
                soundManager.play(sound: .corda3)
            case 5:
                afinador5.run(animate_afinador2(node: afinador5))
                soundManager.play(sound: .corda2)
            case 6:
                afinador6.run(animate_afinador2(node: afinador6))
                soundManager.play(sound: .corda1)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.soundManager.play(sound: .chord)
                }
                numberOfTextDatabase = 3
                destroy_tuning_handler()
                create_text_box(textDatabase: numberOfTextDatabase)
            default:
                break
            }
            
            if numberOfTextDatabase == 1 {
                numberOfTextDatabase = 2
                destroy_tuning_handler()
                create_text_box(textDatabase: numberOfTextDatabase)
            } else if numberOfTextDatabase == 2{
                destroy_and_reapear_handler()
            } else {
                destroy_tuning_handler()
            }
            
            contador_cordas += 1
        }
        
        if text_box != nil && text_box.contains(location) {
            if text_model.title != "End" {
                text_label.attributedText = setup_text(textDatabase: numberOfTextDatabase)
                text_label.alpha = 0
                text_next_indicator.alpha = 0

                let bounce = SKAction.sequence([SKAction.moveTo(y: text_next_indicator.position.y + 5, duration: 0.5), SKAction.moveTo(y: text_next_indicator.position.y - 5, duration: 0.5)])
                let bouncing_forever = SKAction.repeatForever(bounce)
                
                let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
                let scale_back = SKAction.scale(to: 1, duration: 0.2)
                let textBoxBounce = SKAction.sequence([scale_animation, scale_back])
        
                let fade_in_next_indicator = SKAction.sequence([SKAction.wait(forDuration: 1.5), SKAction.fadeIn(withDuration: 0.2)])
        
                let fade_in_with_wait = SKAction.sequence([SKAction.wait(forDuration: 1.2), SKAction.fadeIn(withDuration: 0.4)])
        
                let fade_in = SKAction.sequence([SKAction.fadeIn(withDuration: 0.4)])

                text_box.run(fade_in_with_wait)
                text_box.run(textBoxBounce)
                text_label.run(fade_in)
                text_label.run(textBoxBounce)
                text_next_indicator.run(fade_in_next_indicator)
                text_next_indicator.run(bouncing_forever)
            } else if text_model.title == "End" && numberOfTextDatabase == 1{
                text_next_indicator.removeFromParent()
                
                let fade_out = SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()])

                text_box.run(fade_out)
                text_label.run(fade_out)
                
                // End of first text box, so let's show the tutorial
                
                let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
                let scale_back = SKAction.scale(to: 1, duration: 0.2)
                let bounce = SKAction.sequence([scale_animation, scale_back])
                
                game_tutorial.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeIn(withDuration: 0.5)]))
                pressure_button.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeIn(withDuration: 0.5)]))
                game_tutorial.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), bounce]))
                pressure_button.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), bounce]))
            } else {
                text_next_indicator.removeFromParent()
                
                let fade_out = SKAction.sequence([SKAction.fadeOut(withDuration: 0.5), SKAction.removeFromParent()])

                text_box.run(fade_out)
                text_label.run(fade_out)
                
                let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
                let scale_back = SKAction.scale(to: 1, duration: 0.2)
                let bounce = SKAction.sequence([scale_animation, scale_back])
                
                pressure_button.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), SKAction.fadeIn(withDuration: 0.5)]))
                pressure_button.run(SKAction.sequence([SKAction.wait(forDuration: 0.5), bounce]))
                
                if numberOfTextDatabase == 2 {
                    create_tuning_handler()
                } else if numberOfTextDatabase == 3 {
                    let transition_close_curtain = SKTransition.doorsCloseHorizontal(withDuration: 1.5)
                    let newScene = CurtainTransitionScene()
                    newScene.set(newScene: EndingScene())
                    newScene.size = CGSize(width: 1366, height: 1024)
                    newScene.scaleMode = .aspectFit
                    
                    soundManager.play(sound: .correiaCortina)
                    
                    scene?.view?.presentScene(newScene, transition: transition_close_curtain)
                }
            }
        }
    } 
}
