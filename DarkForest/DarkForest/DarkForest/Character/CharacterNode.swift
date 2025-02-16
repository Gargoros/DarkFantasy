
import SpriteKit
import GameplayKit

class CharacterNode: SKSpriteNode {
    var characterEntity: GKEntity?
    
    var left = false
    var right = false
    var down = false
    
    var jump = false
    var landed = false
    var grounded = false
    
    var maxJump: CGFloat = 60.0
    
    var airAccel: CGFloat = 0.1
    var airDecel: CGFloat = 0.0
    var groundAccel: CGFloat = 0.2
    var groundDecel: CGFloat = 0.5
    
    var facing: CGFloat = 1.0
    
    var hSpeed: CGFloat = 0.0
    var walkSpeed: CGFloat = 3.5
    var stateMachine: GKStateMachine?
    
    func setupStateMachine() {
        characterEntity = GKEntity()
        characterEntity?.addComponent(GKSKNodeComponent(node: self))
        
        let normalState = NormalState(with: self)
        stateMachine = GKStateMachine(states: [normalState])
        stateMachine?.enter(NormalState.self)
    }
}
