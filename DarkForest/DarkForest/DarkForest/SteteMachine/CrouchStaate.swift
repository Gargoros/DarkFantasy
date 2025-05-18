
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
        if !cNode.down {
            stateMachine?.enter(NormalState.self)
            return
        }
        let targetX = cNode.facing * 1.0
        let targetY: CGFloat = 0.7
        cNode.xScale = approach(start: cNode.xScale, end: targetX, shift: 0.05)
        cNode.yScale = approach(start: cNode.yScale, end: targetY, shift: 0.05)
    }
    func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat {
        if start < end {
            return min(start + shift, end)
        }else{
            return max(start - shift, end)
        }
    }
}
