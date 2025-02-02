
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupScene()
    }
}

extension GameScene {
    private func setupScene(){
        setupBackground()
    }
    private func setupBackground(){
        let background = SKSpriteNode(texture: SKTexture(image: .background))
        background.size = CGSize(width: self.frame.size.width * 2, height: self.frame.size.height)
        background.position = CGPoint(x: self.frame.size.width * 0.5, y: self.frame.size.height * 0.5)
        addChild(background)
        
    }
}
