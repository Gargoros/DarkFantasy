
import SpriteKit

class TouchControlInputNode: SKSpriteNode {
    //MARK: - Properties
    var alphaUnpressed: CGFloat = 0.5
    var alphaPressed:   CGFloat = 0.9
    
    var pressedButtons  = [SKSpriteNode]()
    
    let buttonDirUp     = SKSpriteNode(imageNamed: "buttonDirUp")
    let buttonDirDown   = SKSpriteNode(imageNamed: "buttonDirDown")
    let buttonDirLeft   = SKSpriteNode(imageNamed: "buttonDirLeft")
    let buttonDirRight  = SKSpriteNode(imageNamed: "buttonDirRight")
    
    let buttonA      = SKSpriteNode(imageNamed: "buttonA")
    let buttonB      = SKSpriteNode(imageNamed: "buttonB")
    let buttonX      = SKSpriteNode(imageNamed: "buttonX")
    let buttonY      = SKSpriteNode(imageNamed: "buttonY")
    
    var inputDelegate: ControlInputDelegate?
    
    //MARK: - Init
    init(frame: CGRect){
        super.init(texture: nil, color: .clear, size: frame.size)
        setupControls(size: frame.size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Create button
    func addButton(button: SKSpriteNode, position: CGPoint, name: String, scale: CGFloat){
        button.position = position
        button.setScale(scale)
        button.name = name
        button.zPosition = 10
        button.alpha = alphaUnpressed
        self.addChild(button)
    }
    //MARK: - Buttons setups
    func setupControls(size: CGSize){
        addButton(button: buttonDirUp, position: CGPoint(x: -(size.width) / 3, y: -size.height / 4 + 30), name: "buttonUp", scale: 4.5)
        addButton(button: buttonDirDown, position: CGPoint(x: -(size.width) / 3 , y: -size.height / 4 - 30), name: "buttonDown", scale: 4.5)
        addButton(button: buttonDirLeft, position: CGPoint(x: -(size.width) / 3 - 30, y: -size.height / 4), name: "buttonLeft", scale: 4.5)
        addButton(button: buttonDirRight, position: CGPoint(x: -(size.width) / 3 + 30, y: -size.height / 4), name: "buttonRight", scale: 4.5)
        
        addButton(button: buttonA, position: CGPoint(x: size.width / 3, y: -size.height / 4 - 40), name: "buttonA", scale: 3.6)
        addButton(button: buttonB, position: CGPoint(x: size.width / 3 + 40, y: -size.height / 4), name: "buttonB", scale: 3.6)
        addButton(button: buttonX, position: CGPoint(x: size.width / 3 - 40, y: -size.height / 4), name: "buttonX", scale: 3.6)
        addButton(button: buttonY, position: CGPoint(x: size.width / 3, y: -size.height / 4 + 40), name: "buttonY", scale: 3.6)
    }
    //MARK: - Buttons touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight, buttonA, buttonB, buttonX, buttonY]{
                if button.contains(location) && pressedButtons.firstIndex(of: button) == nil{
                    pressedButtons.append(button)
                    inputDelegate?.follow(command: button.name)
                }
                button.alpha = pressedButtons.contains(button) ? alphaPressed : alphaUnpressed
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight, buttonA, buttonB, buttonX, buttonY]{
                if button.contains(previousLocation) && !button.contains(location){
                    if let index = pressedButtons.firstIndex(of: button) {
                        pressedButtons.remove(at: index)
                        inputDelegate?.follow(command: "cancel \(button.name ?? "")")
                    }
                } else if !button.contains(previousLocation) && button.contains(location) && !pressedButtons.contains(button) {
                    pressedButtons.append(button)
                    inputDelegate?.follow(command: button.name)
                }
                button.alpha = pressedButtons.contains(button) ? alphaPressed : alphaUnpressed
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches: touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchUp(touches: touches, with: event)
    }
    
    func touchUp(touches: Set<UITouch>, with event: UIEvent?){
        for touch in touches {
            let location = touch.location(in: self)
            let previousLocation = touch.previousLocation(in: self)
            for button in [buttonDirUp, buttonDirLeft, buttonDirDown, buttonDirRight, buttonA, buttonB, buttonX, buttonY]{
                if button.contains(location) || button.contains(previousLocation) {
                    if let index = pressedButtons.firstIndex(of: button) {
                        pressedButtons.remove(at: index)
                        inputDelegate?.follow(command: "stop \(button.name ?? "")")
                    }
                }
                button.alpha = pressedButtons.contains(button) ? alphaPressed : alphaUnpressed
            }
        }
    }
}
