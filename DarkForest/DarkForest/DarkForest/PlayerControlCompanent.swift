
import SpriteKit
import GameplayKit

class PlayerControlCompanent: GKComponent, ControlInputDelegate {
    //MARK: - Properties
    var touchControlNode: TouchControlInputNode?
    weak var character: CharacterNode?
    
    func setupControls(camera: SKCameraNode, scene: SKScene) {
        touchControlNode = TouchControlInputNode(frame: scene.frame)
        touchControlNode?.inputDelegate = self
        touchControlNode?.position = .zero
        camera.addChild(touchControlNode!)
        
        guard let entity = self.entity,
              let nodeComponent = entity.component(ofType: GKSKNodeComponent.self),
              let characterNode = nodeComponent.node as? CharacterNode else {
            print("Failed to connect controls to character")
            return
        }
        
        character = characterNode
    }
    
    func follow(command: String?) {
        guard let command = command else { return }
        switch command {
        case "buttonLeft":
            character?.left = true
        case "buttonRight":
            character?.right = true
        case "cancel buttonLeft", "stop buttonLeft":
            character?.left = false
        case "cancel buttonRight", "stop buttonRight":
            character?.right = false
        default: break
        }
    }
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)
        character?.stateMachine?.update(deltaTime: seconds)
    }
}
