
import GameplayKit

class NormalState: GKState{
    
    var cNode: CharacterNode
    init(with node: CharacterNode){
        cNode = node
    }
    
    override func didEnter(from previousState: GKState?) {
        cNode.color = UIColor.blue
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        var aSpeed: CGFloat = 0.0
        var dSpeed: CGFloat = 0.0
        
        if (cNode.grounded) {
            aSpeed = cNode.groundAccel
            dSpeed = cNode.groundDecel
        } else {
            aSpeed = cNode.airAccel
            dSpeed = cNode.airDecel
        }
        
        //MARK: - Movement
        if cNode.left{
            cNode.facing = -1.0
            cNode.xScale = -1.0
            cNode.hSpeed = approach(start: cNode.hSpeed, end: -cNode.walkSpeed, shift: aSpeed)
        }else if cNode.right{
            cNode.facing = 1.0
            cNode.xScale = 1.0
            cNode.hSpeed = approach(start: cNode.hSpeed, end: cNode.walkSpeed, shift: aSpeed)
        }else {
            cNode.hSpeed = approach(start: cNode.hSpeed, end: 0.0, shift: dSpeed)
        }
        //MARK: - Jump
        if cNode.grounded {
            if !cNode.landed {
                squashAndStretch(xScale: 1.3, yScale: 0.7)
                cNode.physicsBody?.velocity = CGVector(dx: (cNode.physicsBody?.velocity.dx)!, dy: 0.0)
                cNode.landed = true
            }
            if cNode.jump {
                cNode.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: cNode.maxJump))
                cNode.grounded = false
                squashAndStretch(xScale: 0.7, yScale: 1.3)
            }
        }
        if !cNode.grounded{
            if (cNode.physicsBody?.velocity.dy)! < CGFloat(0.0){
                cNode.jump = false
            }
            if (cNode.physicsBody?.velocity.dy)! > CGFloat(0.0) && !cNode.jump{
                cNode.physicsBody?.velocity.dy *= 0.5
            }
            cNode.landed = false
        }
        if cNode.down {
            squashAndStretch(xScale: 1.3, yScale: 0.7)
            self.stateMachine?.enter(CrouchStaate.self)
        }
        //MARK: - Updates
        cNode.xScale = approach(start: cNode.xScale, end: cNode.facing, shift: 0.05)
        cNode.yScale = approach(start: cNode.yScale, end: 1, shift: 0.05)
        cNode.position.x = cNode.position.x + cNode.hSpeed
    }
    
    private func approach(start: CGFloat, end: CGFloat, shift: CGFloat) -> CGFloat{
        if (start < end) { min(start + shift, end) }
        else { max(start - shift, end) }
    }
    
    private func squashAndStretch(xScale: CGFloat, yScale: CGFloat){
        cNode.xScale = xScale * cNode.facing
        cNode.yScale = yScale
    }
    
}
