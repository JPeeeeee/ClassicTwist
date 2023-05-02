import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        let scene = StartScreen()
        scene.size = CGSize(width: 1366, height: 1024)
        scene.scaleMode = .aspectFit
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .font(Font.custom("Acme-Regular", size: 20))
    }
}
