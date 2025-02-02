
import SpriteKit
import GameplayKit

class CharacterNode: SKSpriteNode {
    var characterEntity: GKEntity?
    var left = false
    var right = false
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
