//
//  TextView.swift
//  WWDC23
//
//  Created by João Pedro Vieira Santos on 06/04/23.
//

import SpriteKit

class teste: SKScene {
    
    // Declaração do seu elemento, vulgo caixinha de texto
    private var seuSpriteNode: SKSpriteNode!
    
    
    // essa funçao aqui é a que faz alguma coisa quando essa tela carrega
    override func didMove(to view: SKView) {
        
        // essas 3 linhas sao pra inicializar a caixa de texto com o tamanho da imagem e coloca ela no meio da tela fodasekkkkkkkkk
        seuSpriteNode = SKSpriteNode(imageNamed: "oNomeDaSuaImagem")
        seuSpriteNode.size = CGSize(width: seuSpriteNode.frame.width, height: seuSpriteNode.frame.height)
        seuSpriteNode.position = CGPoint(x: frame.midX, y: frame.midY)
        
        
        // insere ela na tela
        addChild(seuSpriteNode)
    }
    
    
    // funcao que roda quando tu levantar o dedo da tela
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // coloca as coordenadas (a elite da matematica em açao aqui) do seu toque na variavel 'location'
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        
        
        // cria a bendita da animaçao da caixinha de texto
        let scale_animation = SKAction.scale(to: 0.8, duration: 0.2)
        let scale_back = SKAction.scale(to: 1, duration: 0.2)
        let textBoxBounce = SKAction.sequence([scale_animation, scale_back])
        
        
        
        // se o clique acabar dentro da sua caixinha ela roda a animacao que vc criou e pronto 😎
        if seuSpriteNode.contains(location) {
            seuSpriteNode.run(textBoxBounce)
        }
    }
}
