
import SpriteKit
import GameplayKit

class PlayerControlCompanent: GKComponent, ControlInputDelegate {
    //MARK: - Properties
    var touchControlNode: TouchControlInputNode?
    
    func setupControls(camera: SKCameraNode, scene: SKScene){
        touchControlNode = TouchControlInputNode(frame: scene.frame)
        touchControlNode?.inputDelegate = self
        touchControlNode?.position = CGPoint.zero
        
        camera.addChild(touchControlNode!)
    }
    
    func follow(command: String?) {
        print("command: \(String(describing: command))")
    }    
}
