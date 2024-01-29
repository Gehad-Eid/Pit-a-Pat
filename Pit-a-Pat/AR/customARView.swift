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
        
        //setUpARView()
        
//         add a blurred rectangle if the parameter is true
        if shouldAddBlurredRectangle {
            addBlurredRectangle()
        }
        
        boxadd()
    }
    
    // Configuration
    func setUpARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        session.run(config)
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        Manager.shared
            .ARStream
            .sink { [weak self] action in
                switch action {
                case .generateHoles(let difficulty):
                    self?.generateHoles(difficulty: difficulty)
                    
                case .throwBalls:
                    self?.throwBalls()
                    
                case .removeAll:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellables)
    }
    
    func boxadd() {
        let hole = try? Entity.load(named: "Hole")
        let ball = try? Entity.load(named: "Ball")
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        anchor.addChild(hole!)
        anchor.addChild(ball!)
        
        scene.addAnchor(anchor)
    }
    
    func generateHoles(difficulty: Int) {
        
    }
    
    func throwBalls() {
        
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
