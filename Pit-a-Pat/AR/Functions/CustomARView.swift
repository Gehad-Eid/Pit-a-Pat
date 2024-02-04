//  Created by Gehad Eid and Abrar Ghandurah  (best colap ever) on 28/01/2024.

import SwiftUI
import ARKit
import RealityKit
import Combine

class CustomARView : ARView {
    //    static let sharedAR = CustomARView()
    
    var profileVM: ProfileViewModel // Assuming ProfileViewModel is already defined elsewhere

        // Updated required initializer to include ProfileViewModel parameter
        required init(frame frameRect: CGRect, profileVM: ProfileViewModel) {
            self.shouldAddBlurredRectangle = false
            self.profileVM = profileVM
            super.init(frame: frameRect)
//            setUpARView() // Assuming you want to set up the AR view upon initialization
        }
    
    dynamic required init?(coder decoder: NSCoder) {
        fatalError("init?(coder decoder: NSCoder) isn't implemented")
    }
    
    var shouldAddBlurredRectangle: Bool
//    var profileVM: ProfileViewModel
    
    convenience init(frame frameRect: CGRect = UIScreen.main.bounds, shouldAddBlurredRectangle: Bool = false, profileVM: ProfileViewModel) {
            self.init(frame: frameRect, profileVM: profileVM)
        self.shouldAddBlurredRectangle = shouldAddBlurredRectangle
        
        // Set the configuration
        setUpARView()
        
        //add a blurred rectangle if the parameter is true
        if shouldAddBlurredRectangle {
            addBlurredRectangle()
        }
        
        subscribeToARStream()

        startSceneUpdate()
        
    }
    
    @MainActor override required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    // Property to store the trigger volume
    var triggerVolume = TriggerVolume(shape: .generateBox(size: [0.2,0.2,0.2]), filter: .sensor)
    
    // Function to create and update anchors
    func updateAnchors() {
        // Remove the anchor from the previous frame
        triggerVolume.removeFromParent()
        
        // Create a new anchor at the camera's position
        let cameraTransform = self.cameraTransform

        let newTriggerVolume =  TriggerVolume(shape: .generateBox(size: [0.2,0.2,0.2]), filter: CollisionFilter(group: CollisionGroup(rawValue: 2), mask: CollisionGroup(rawValue: 1)))
        newTriggerVolume.transform = cameraTransform
        newTriggerVolume.name = "triggerVolume"
        
        // Add the new anchor to the scene
        scene.anchors.append(newTriggerVolume)
        
        // Save the reference to the current anchor
        triggerVolume = newTriggerVolume
    }
    
    var count = 0
    
//    @StateObject var profileVM = ProfileViewModel()

    
    var collisionSubscriptions = [Cancellable]()
    func addCollisionListening(onEntity entity: Entity & HasCollision) {
        collisionSubscriptions.append(self.scene.subscribe(to: CollisionEvents.Began.self, on: entity) {  /*[weak self]*/ event in
            
            self.count += 1
            self.profileVM.score += 1
//            await self.profileVM.saveProfile()
            //Place code here for when the collision begins.
            print(event.entityA.name, "collided with", event.entityB.name)
//            print(self.count)
            print(self.profileVM.score)
            self.scene.anchors.removeAll()
        })
        collisionSubscriptions.append(self.scene.subscribe(to: CollisionEvents.Ended.self, on: entity) { event in
            print(event.entityA.name, "stoped colliding with", event.entityB.name)
            //Place code here for when the collision ends.
        })
    }
    
    
    // Subscribe to scene updates
    private var sceneUpdateCancellable: Cancellable?
    
    // Function to start subscribing to scene updates
    func startSceneUpdate() {
        sceneUpdateCancellable = scene.subscribe(to: SceneEvents.Update.self) { [weak self] _ in
            self?.updateAnchors()
        }
    }
    
    // Function to stop subscribing to scene updates
    func stopSceneUpdate() {
        sceneUpdateCancellable?.cancel()
        sceneUpdateCancellable = nil
    }
    
    
    // Array of entity names
    let entityNames = ["Ball0", "Ball1", "Ball2", "Ball3"]
    
    // BallEntity property
    var BallEntity = try? Entity.load(named: "Ball0")
    
    
    //  Function to throw balls
    func throwBalls() {
        // Shuffle the array to randomize entity selection
        var shuffledEntityNames = entityNames.shuffled()
        print(shuffledEntityNames)
        
        let anchors = scene.anchors.compactMap { $0 as? AnchorEntity }
        
        let name = shuffledEntityNames.first
        print(name!)
        
        // Attempt to load the BallEntity
        BallEntity = try? Entity.load(named: name ?? "Ball0")
        BallEntity?.name = name!
        
        BallEntity?.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateBox(size: [0.2,0.2,0.2])],
            mode: .trigger,
            filter: CollisionFilter(group: CollisionGroup(rawValue: 1), mask: CollisionGroup(rawValue: 2))
        )
        
        addCollisionListening(onEntity: BallEntity! as Entity & HasCollision)
        
        print("did load \(BallEntity!)")
        
        
        var didAddBall = false
        
        for anchor in anchors {
            // Select a random ball
            let randomBallEntityName = shuffledEntityNames.randomElement()
            let randomBallEntity = try? Entity.load(named: randomBallEntityName ?? "")
            
            // Add 2 balls of the same color to the scene
            if !didAddBall {
                
                anchor.addChild(BallEntity!)
                didAddBall = true
                print("sameBallcount = \(didAddBall)")
                
                // Remove the ball from the array
                shuffledEntityNames.removeFirst()
                print("did add 2 ")
            } else {
                anchor.addChild(randomBallEntity!)
                print("did add 1")
            }
        }
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
        hole?.name = "Hole"
        
        let anchor = AnchorEntity(plane: .horizontal)
        
        anchor.addChild(hole!)
        
        scene.addAnchor(anchor)
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

extension TriggerVolume : HasAnchoring{}
extension Entity : HasCollision{}
