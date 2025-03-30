
import SpriteKit
import GameplayKit

class CrouchStaate: GKState{
    
    var cNode: CharacterNode
    
    init(withNode node: CharacterNode){
        self.cNode = node
    }
    
    override func didEnter(from previousState: GKState?) {
        cNode.color = UIColor.blue
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        if cNode.down {
            stateMachine?.enter(NormalState.self)
        }
        cNode.xScale = approach(start: cNode.xScale, end: cNode.facing, shift: 0.05)
        cNode.yScale = approach(start: cNode.yScale, end: 1.0, shift: 0.05)
    }
    func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat {
        if start < end {
            min(start + shift, end)
        }else{
            max(start - shift, end)
        }
    }
}
