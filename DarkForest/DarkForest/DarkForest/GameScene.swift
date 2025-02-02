
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var lastUpdateTime: TimeInterval = 0
    let playerEntity = GKEntity()
    var character: CharacterNode!
    
    override func didMove(to view: SKView) {
        let cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode)
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
        character = CharacterNode(color: .blue, size: CGSize(width: 40, height: 60))
        character.position = CGPoint(x: frame.midX, y: frame.midY)
        character.name = "Player"
        addChild(character)
        
        character.setupStateMachine()
        
        let controlComponent = PlayerControlCompanent()
        character.characterEntity?.addComponent(controlComponent)
        controlComponent.setupControls(camera: cameraNode, scene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 { lastUpdateTime = currentTime }
        let dt = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        
        character.characterEntity?.update(deltaTime: dt)
    }
}
