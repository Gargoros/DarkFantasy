
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private var lastUpdateTime: TimeInterval = 0
    
    let playerEntity = GKEntity()
    var character: CharacterNode!
    var physicsDelegate = PhysicsDetection()
    
    var cameraNode = SKCameraNode()
    var controlComponent = PlayerControlCompanent()
    
    var floor = SKSpriteNode()
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setupScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpdateTime == 0 { lastUpdateTime = currentTime }
        let dt = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        character.characterEntity?.update(deltaTime: dt)
    }
}
extension GameScene {
    private func setupScene(){
        self.physicsWorld.contactDelegate = physicsDelegate
        setupBackground()
        setupFloor()
        setupCamera()
        setupPlayer()
        setupControlComponent()
    }
    private func setupCamera(){
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        addChild(cameraNode)
        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }
    private func setupPlayer(){
        character = CharacterNode(color: .blue, size: CGSize(width: 40, height: 60))
        character.position = CGPoint(x: frame.midX, y: frame.midY)
        character.name = "Player"
        character.zPosition = ZPosition.character
        addChild(character)
        
        character.physicsBody = SKPhysicsBody(rectangleOf: character.size)
        character.physicsBody?.categoryBitMask = ColliderType.PLAYER
        character.physicsBody?.contactTestBitMask = ColliderType.GROUND
        character.physicsBody?.collisionBitMask = ColliderType.GROUND
        character.physicsBody?.isDynamic = true
        
        character.setupStateMachine()
    }
    private func setupControlComponent(){
        controlComponent = PlayerControlCompanent()
        character.characterEntity?.addComponent(controlComponent)
        controlComponent.setupControls(camera: cameraNode, scene: self)
    }
    private func setupBackground(){
        let background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSize(width: frame.size.width * 2, height: frame.size.height * 2)
        background.position = CGPoint(x: frame.midX, y: frame.midY + frame.size.height * 0.5)
        background.zPosition = ZPosition.background
        addChild(background)
    }
    private func setupFloor(){
        floor = SKSpriteNode(imageNamed: "bg_floorLayer")
        floor.size = CGSize(width: frame.size.width * 2, height: frame.size.height * 0.3)
        floor.position = CGPoint(x: frame.midX, y: frame.minY)
        floor.zPosition = ZPosition.background
        
        floor.physicsBody = SKPhysicsBody(rectangleOf: floor.size)
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.restitution = 0.0
        floor.physicsBody?.categoryBitMask = ColliderType.GROUND
        floor.physicsBody?.contactTestBitMask = ColliderType.PLAYER
        floor.physicsBody?.collisionBitMask = ColliderType.PLAYER
        
        addChild(floor)
        
    }
}
