//  Created by Gehad Eid on 28/01/2024.

import SwiftUI
import ARKit
import RealityKit
import Combine

class CustomARView : ARView {
    required init(frame frameRect: CGRect) {
        shouldAddBlurredRectangle = false
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init?(coder decoder: NSCoder) isn't implemented")
    }
    
    var shouldAddBlurredRectangle: Bool
    
    convenience init(shouldAddBlurredRectangle: Bool = false){
        self.init(frame: UIScreen.main.bounds)
        self.shouldAddBlurredRectangle = shouldAddBlurredRectangle
        
        // Set the configuration
        setUpARView()
        
        
        
        //add a blurred rectangle if the parameter is true
        if shouldAddBlurredRectangle {
            addBlurredRectangle()
        }
        
//        boxadd()
        
        subscribeToARStream()
        
    }
    
    // Configuration
    func setUpARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        session.run(config)
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToARStream() {
        Manager.shared
            .ARStream
            .sink { [weak self] action in
                switch action {
                case .addHoles: //.addHoles(let difficulty):
                    self?.addHoles()
                    
                case .throwBalls:
                    self?.throwBalls()
                    
                case .removeAll:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    func addHoles() {
        let hole = try? Entity.load(named: "Hole")
//        let ball = try? Entity.load(named: "Ball")
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        anchor.addChild(hole!)
//        anchor.addChild(ball!)
        
        scene.addAnchor(anchor)
    }
    
//    func generateHoles(difficulty: Int) {
//        // Clear existing anchors
//        scene.anchors.removeAll()
//        
//        // Create anchors with the specified spacing
//        for _ in 0..<difficulty {
//            
//            let xPosition = Float.random(in: -1.5/2...1.5/2)
//            let zPosition = Float.random(in: -1.5/2...1.5/2)
////            let yPosition = Float.random(in: -1.5/2...0/2)
//            
//            var anchorTransform = matrix_identity_float4x4
//            anchorTransform.columns.3.x = xPosition
//            anchorTransform.columns.3.z = zPosition
//
//           // let arAnchor = ARAnchor(transform: cameraTransform.matrix)
//            
//            let anchor = AnchorEntity(world: anchorTransform)
//            
//            //            let xPosition = Float(i) * 0.6
//            //            var anchorTransform = matrix_identity_float4x4
//            //            anchorTransform.columns.3.x = xPosition
//            
//            //            let anchor = AnchorEntity(world: anchorTransform)
//            
//            let hole = try! ModelEntity.load(named: "Hole")
////            let ball = try? Entity.load(named: "Ball")
//            
//            anchor.addChild(hole)
////            anchor.addChild(ball!)
//            
//            scene.addAnchor(anchor)
//        }
//    }
    
    func throwBalls() {
        // Create an array of entity names
        let entityNames = ["Ball0", "Ball1", "Ball2", "Ball3"]
        
        // Shuffle the array to randomize entity selection
        var shuffledEntityNames = entityNames.shuffled()
        
        let anchors = scene.anchors.compactMap { $0 as? AnchorEntity }
        
        let BallEntity = try? Entity.load(named: shuffledEntityNames.first ?? "")
        
        for anchor in anchors {
            // Select a random ball
            let randomBallEntityName = shuffledEntityNames.randomElement()
            let randomBallEntity = try? Entity.load(named: randomBallEntityName ?? "")
            
            // Check if the ball is in the scene or not
            if (randomBallEntity == BallEntity) {
                
                // Add 2 balls of the same color to the scene
                anchor.addChild(randomBallEntity!)
                anchor.addChild(randomBallEntity!)
                
                // Remove the ball from the array
                shuffledEntityNames.removeFirst()
            }else{
                anchor.addChild(randomBallEntity!)
            }
        }
    }
    
    
    // Function to add a blurred rectangle
    func addBlurredRectangle() {
        let blurredRectangle = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blurredRectangle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurredRectangle)
        
        blurredRectangle.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        blurredRectangle.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        blurredRectangle.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurredRectangle.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
