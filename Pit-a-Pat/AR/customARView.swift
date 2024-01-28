//  Created by Gehad Eid on 28/01/2024.

import SwiftUI
import ARKit
import RealityKit
import Combine

class customARView : ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init?(coder decoder: NSCoder) isn't implemented")
    }
    
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
//        setUpARView()
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
}
