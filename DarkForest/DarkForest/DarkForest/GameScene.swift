
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var lastUpdateTime: TimeInterval = 0
    let playerEntity = GKEntity()
    
    override func didMove(to view: SKView) {
        let cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode)
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        
        let playerNode = SKSpriteNode(color: .red, size: CGSize(width: 40, height: 40))
        playerNode.name = "Player"
        addChild(playerNode)
        
        let controlComponent = PlayerControlCompanent()
        playerEntity.addComponent(controlComponent)
        controlComponent.setupControls(camera: cameraNode, scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 { lastUpdateTime = currentTime }
        let dt = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        playerEntity.update(deltaTime: dt)
    }
}
